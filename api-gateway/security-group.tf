resource "aws_security_group" "vpc_endpoint_sg" {
  vpc_id = var.vpc_id
  name   = var.vpc_endpoint_sg_name
}

