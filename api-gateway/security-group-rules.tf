resource "aws_security_group_rule" "outbound_from_vpc_endpoint" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.vpc_endpoint_sg.id
}

resource "aws_security_group_rule" "inbound" {
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.vpc_endpoint_sg.id
  to_port                  = 443
  type                     = "ingress"
  source_security_group_id = var.source_security_group_id
}