module "api_gateway" {
  source = ".//api-gateway"

  vpc_id                     = data.terraform_remote_state.vpc.outputs.vpc_id
  private_subnet_ids         = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  source_security_group_id   = data.terraform_remote_state.load_balancers.outputs.frontend_sg_id
  private_load_balancer_arn  = data.terraform_remote_state.load_balancers.outputs.nlb_arn
  internal_load_balancer_dns = data.terraform_remote_state.load_balancers.outputs.nlb_dns
  stage_name                 = var.stage_name
  path_parts                 = var.path_parts
  ports                      = var.ports
  http_methods               = var.http_methods
  metrics_enabled            = var.metrics_enabled
  integration_http_method    = var.integration_http_method
  service_count              = var.service_count
  rest_api_name              = var.rest_api_name
  vpc_link_name              = var.vpc_link_name
  vpc_endpoint_sg_name       = var.vpc_endpoint_sg_name

}
