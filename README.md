# Multi-Tier-AWS-VPC-with-Terraform

## Architecture Overview

3-tier cloud DMZ architecture demonstrating enterprise network segmentation and security best practices.

### Design
```
Internet
    ↓
[Internet Gateway]
    ↓
┌─────────────────────────────────┐
│  DMZ Tier (Public Subnets)      │
│  - 10.0.0.0/20, 10.0.128.0/20   │
│  - Security Group: HTTP/HTTPS   │
└─────────────────────────────────┘
    ↓
┌─────────────────────────────────┐
│  Application Tier (Private)     │
│  - 10.0.16.0/20, 10.0.144.0/20  │
│  - Security Group: DMZ only     │
└─────────────────────────────────┘
    ↓
┌─────────────────────────────────┐
│  Database Tier (Isolated)       │
│  - 10.0.32.0/24, 10.0.33.0/24   │
│  - Security Group: App only     │
└─────────────────────────────────┘
```

## Key Features

### Security
- **Layered Security Groups**: Micro-segmentation between tiers
- **Least Privilege Access**: Each tier only accepts traffic from the previous tier
- **No Direct Internet Access**: Private/database tiers are isolated

### High Availability
- **Multi-AZ Deployment**: 2 subnets per tier across us-east-1a and us-east-1b
- **Fault Tolerance**: Resources can be distributed for redundancy

### Automation
- **Infrastructure as Code**: Entire environment defined in Terraform
- **Reproducible**: Deploy in ~3 minutes with `terraform apply`
- **Version Controlled**: All changes tracked in Git

## Infrastructure Details

### VPC
- **CIDR**: 10.0.0.0/16
- **DNS Hostnames**: Enabled
- **DNS Support**: Enabled

### Subnets (6 total)
- **Public**: 2 subnets with internet gateway access
- **Private**: 2 subnets with no internet access
- **Database**: 2 subnets completely isolated

### Security Groups (3 total)
- **DMZ SG**: Allows HTTP (80) and HTTPS (443) from internet
- **Application SG**: Allows port 8080 from DMZ security group only
- **Database SG**: Allows port 3306 (MySQL) from application security group only

## Technologies Used
- Terraform 1.2+
- AWS VPC, Subnets, Route Tables
- AWS Security Groups
- AWS Internet Gateway

## Deployment

### Prerequisites
- AWS Account
- AWS CLI configured
- Terraform installed

### Deploy
```bash
terraform init
terraform plan
terraform apply
```

### Outputs
```bash
terraform output
```

## Design Decisions

### Why No NAT Gateway?
For cost optimization in this lab environment. In production, I would add NAT Gateway to allow private subnets secure outbound internet access for updates and API calls.

### Why Multi-AZ?
Demonstrates understanding of high availability principles. In production, this allows applications to survive availability zone failures.

### Why Layered Security Groups?
Even if one tier is compromised, lateral movement is restricted by security group rules.

## Relevance to Role

This lab demonstrates:
- Cloud DMZ architecture knowledge
- Infrastructure automation skills
- Security segmentation understanding
- High availability design
- Infrastructure-as-Code implementation


## Author
Created: November 2025  

