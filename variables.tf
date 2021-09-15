# tags
variable "owner" {
  default = "sophie"
}

# module inputs
variable "stage_name" {
  description = "The name of the stage(a named reference to a deployment)"
  type = string
}

variable "path_parts" {
  description = "The last part of the path, minus the /."
  type = list(string)
}

variable "ports" {
  description = "The ports that the services are running on. This is used to make up the uri string in the integration"
  type = list(number)
}

variable "http_methods" {
  description = "The http methods for each resource"
  type = list(string)
}

variable "metrics_enabled" {
  description = "true or false value as to whether metrics should be enabled for each method"
  type = bool
}

variable "integration_http_method" {
  description = "HTTP method with which API Gateway will interact with the backend"
  type = string
}

variable "service_count" {
  description = "Number of services that API Gateway will direct traffic to, dictates the number of methods, resources and integrations)"
  type = number
}

variable "rest_api_name" {
  description = "The name of the API Gateway"
  type = string
}

variable "vpc_link_name" {
  description = "The name of the VPC link"
  type = string
}

variable "vpc_endpoint_sg_name" {
  description = "The name of the VPC Endpoint Security Group"
  type = string
}




