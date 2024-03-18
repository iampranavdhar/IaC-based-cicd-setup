output "nat_gateway_ids" {
  value = aws_nat_gateway.nat_gateways[*].id
}

output "vpc_id" {
  value = aws_vpc.jenkins_vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}