output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.vpc.id
}

output "vpc_cidr" {
  description = "VPC CIDR block"
  value       = aws_vpc.vpc.cidr_block
}

output "public_subnet_ids" {
  description = "Public (DMZ) subnet IDs"
  value       = aws_subnet.public_subnet[*].id
}

output "private_subnet_ids" {
  description = "Private (application) subnet IDs"
  value       = aws_subnet.private_subnet[*].id
}

output "database_subnet_ids" {
  description = "Database subnet IDs"
  value       = aws_subnet.database_subnet[*].id
}

output "security_groups" {
  description = "Security group IDs by tier"
  value = {
    dmz         = aws_security_group.dmz.id
    application = aws_security_group.application.id
    database    = aws_security_group.database.id
  }
}

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.ig.id
}

output "availability_zones" {
  description = "Availability zones used"
  value       = local.availability_zones
}