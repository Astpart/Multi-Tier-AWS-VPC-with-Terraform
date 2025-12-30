# DMZ Security Group (Public tier)
resource "aws_security_group" "dmz" {
  name        = "${var.environment}-dmz-sg"
  description = "DMZ tier - accepts traffic from internet"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "HTTPS from Internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-dmz-sg"
    Environment = var.environment
    Tier        = "dmz"
  }
}

# Application Security Group (Private tier)
resource "aws_security_group" "application" {
  name        = "${var.environment}-app-sg"
  description = "Application tier - only from DMZ"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description     = "App traffic from DMZ only"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.dmz.id]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-app-sg"
    Environment = var.environment
    Tier        = "application"
  }
}

# Database Security Group (Data tier)
resource "aws_security_group" "database" {
  name        = "${var.environment}-db-sg"
  description = "Database tier - only from application"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description     = "MySQL from application only"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.application.id]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-db-sg"
    Environment = var.environment
    Tier        = "data"
  }
}