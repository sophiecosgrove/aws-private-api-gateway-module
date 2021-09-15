# Private Amazon API Gateway

## Example Usage
* Full infrastructure for this example can be found here: https://github.com/sophiecosgrove/terraform-api-gateway-demo
```
module "api_gateway" {
  source = ".//api-gateway"

  vpc_id                     = data.terraform_remote_state.vpc.outputs.vpc_id
  private_subnet_ids         = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  source_security_group_id   = data.terraform_remote_state.load_balancers.outputs.frontend_sg_id
  private_load_balancer_arn  = data.terraform_remote_state.load_balancers.outputs.nlb_arn
  internal_load_balancer_dns = data.terraform_remote_state.load_balancers.outputs.nlb_dns
  stage_name                 = "deploy"
  path_parts                 = ["products", "users", "images"]
  ports                      = [3001, 3002, 3002]
  http_methods               = ["GET", "GET", "GET"]
  metrics_enabled            = true
  http_or_http_proxy         = "HTTP_PROXY"
  integration_http_method    = "GET"
  service_count              = 3
  rest_api_name              = "sophie-rest-api"
  vpc_link_name              = "sophie-vpc-link"
  vpc_endpoint_sg_name       = "vpc-endpoint-sg"

}
```

* `service_count` - This is the number of service endpoints you want your API Gateway to point to. This will determine how many methods, integrations and resources are made.
* `path_parts` - The last part of the path, minus the /.
* `ports` - The ports that the services are running on.
* _Note:_ `path_parts`, `ports` and `http_methods` need to be defined in the same order due to the iteration. E.g "products" runs on port 3001 and uses "GET" method. There must be the same number of elements in each list as defined in `service_count`.
* The `method_settings` resource is set to be the same for all method paths, if you require different settings for each method, set the count parameter, replace `"*/*"` with `"${aws_api_gateway_resource.resource[count.index].path_part}/${aws_api_gateway_method.method[count.index].http_method}"` and configure as desired.