resource "aws_vpc_endpoint" "vpc_endpoint" {
  service_name        = "com.amazonaws.eu-central-1.execute-api"
  vpc_id              = var.vpc_id
  subnet_ids          = var.private_subnet_ids
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]
}








