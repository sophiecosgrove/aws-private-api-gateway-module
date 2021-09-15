resource "aws_api_gateway_rest_api" "rest_api" {
  name = var.rest_api_name
  endpoint_configuration {
    types            = ["PRIVATE"]
    vpc_endpoint_ids = [aws_vpc_endpoint.vpc_endpoint.id]
  }
}

resource "aws_api_gateway_vpc_link" "vpc_link" {
  name        = var.vpc_link_name
  target_arns = [var.private_load_balancer_arn]
}

resource "aws_api_gateway_rest_api_policy" "api_gateway_policy" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": "*",
        "Action": "execute-api:Invoke",
        "Resource": [
          "execute-api:/*"
        ]
      },
      {
        "Effect": "Deny",
        "Principal": "*",
        "Action": "execute-api:Invoke",
        "Resource": [
          "execute-api:/*"
        ],
        "Condition" : {
          "StringNotEquals": {
            "aws:SourceVpce": "${aws_vpc_endpoint.vpc_endpoint.id}"
          }
        }
      }
    ]
  }
EOF
}

resource "aws_api_gateway_deployment" "api_gateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.rest_api.body))
  }

  variables = {
    "version" = timestamp()
  }

  depends_on = [aws_api_gateway_integration.integration]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "stage" {
  deployment_id = aws_api_gateway_deployment.api_gateway_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  stage_name    = var.stage_name
}


resource "aws_api_gateway_resource" "resource" {
  count       = var.service_count
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_rest_api.rest_api.root_resource_id
  path_part   = var.path_parts[count.index]
}

resource "aws_api_gateway_method" "method" {
  count         = var.service_count
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.resource[count.index].id
  http_method   = var.http_methods[count.index]
  authorization = "NONE"
}

resource "aws_api_gateway_method_settings" "method_settings" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  stage_name  = aws_api_gateway_stage.stage.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = var.metrics_enabled
  }
}

resource "aws_api_gateway_integration" "integration" {
  count                   = var.service_count
  http_method             = aws_api_gateway_method.method[count.index].http_method
  resource_id             = aws_api_gateway_resource.resource[count.index].id
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  type                    = "HTTP_PROXY"
  integration_http_method = var.integration_http_method
  connection_type         = "VPC_LINK"
  connection_id           = aws_api_gateway_vpc_link.vpc_link.id
  uri                     = "http://${var.internal_load_balancer_dns}:${var.ports[count.index]}/${var.path_parts[count.index]}"

}
