# names
variable "rest_api_name" {}
variable "vpc_link_name" {}
variable "vpc_endpoint_sg_name" {}

# external inputs
variable "vpc_id" {}
variable "private_subnet_ids" {}
variable "source_security_group_id" {}
variable "private_load_balancer_arn" {}
variable "internal_load_balancer_dns" {}

# config
variable "stage_name" {}
variable "path_parts" {}
variable "http_methods" {}
variable "metrics_enabled" {}
variable "ports" {}
variable "integration_http_method" {}

# services
variable "service_count" {}

