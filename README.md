# Terraform AWS Automation Project

A comprehensive Terraform infrastructure as code project that automates the deployment of a highly available web application on AWS with load balancing, auto-scaling capabilities, and multi-AZ deployment.

## 🏗️ Architecture Overview

This project creates a complete AWS infrastructure including:

- **VPC** with custom CIDR block (10.0.0.0/16)
- **Multi-AZ Subnets** in us-east-1a and us-east-1b
- **Internet Gateway** for public internet access
- **Route Tables** configured for public subnets
- **Security Groups** with HTTP (80) and SSH (22) access
- **S3 Bucket** for static content storage
- **EC2 Instances** running Apache web servers
- **Application Load Balancer** with health checks
- **Target Groups** for traffic distribution

## 📁 Project Structure

```
terraform-aws-automation/
├── main.tf              # Main infrastructure configuration
├── variables.tf         # Variable definitions
├── provider.tf          # AWS provider configuration
├── userdata.sh          # EC2 instance 1 user data script
├── userdata1.sh         # EC2 instance 2 user data script
├── .gitignore           # Git ignore file
├── .terraform.lock.hcl  # Terraform dependency lock file
└── README.md            # This file
```

## 🚀 Features

- **High Availability**: Multi-AZ deployment across us-east-1a and us-east-1b
- **Load Balancing**: Application Load Balancer with health checks
- **Auto-scaling Ready**: Infrastructure designed for easy auto-scaling group integration
- **Security**: Properly configured security groups with minimal required access
- **Monitoring**: Health checks configured for the load balancer
- **Custom Web Content**: Dynamic HTML pages showing instance information

## 🛠️ Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- AWS account with permissions to create VPC, EC2, ALB, and S3 resources

## 🔧 Configuration

### AWS Provider
- **Region**: us-east-1
- **Provider Version**: 5.11.0

### Network Configuration
- **VPC CIDR**: 10.0.0.0/16
- **Subnet 1**: 10.0.0.0/24 (us-east-1a)
- **Subnet 2**: 10.0.1.0/24 (us-east-1b)

### Instance Configuration
- **AMI**: (Amazon Linux 2)
- **Instance Type**: t2.micro
- **Security Group**: Allows HTTP (80) and SSH (22) access

## 📋 Usage

### 1. Initialize Terraform
```bash
terraform init
```

### 2. Review the Plan
```bash
terraform plan
```

### 3. Apply the Infrastructure
```bash
terraform apply
```

### 4. Access Your Application
After successful deployment, Terraform will output the load balancer DNS name. Use this URL to access your web application.

### 5. Destroy Infrastructure (when done)
```bash
terraform destroy
```

## 🌐 Access Points

- **Load Balancer**: Public DNS name provided in Terraform output
- **Direct Instance Access**: SSH access available on port 22
- **Web Application**: HTTP access on port 80

## 📊 Outputs

The project provides the following output:
- `loadbalancerdns`: The DNS name of the Application Load Balancer

## 🔒 Security Considerations

- Security groups are configured with minimal required access
- HTTP traffic is open for web access
- SSH access is available for administration
- All outbound traffic is allowed for updates and package installation

## 🚨 Important Notes

- **Cost**: Running t2.micro instances and ALB will incur AWS charges
- **Region**: Currently configured for us-east-1 region
- **AMI**: Uses a specific AMI ID - ensure it exists in your target region
- **S3 Bucket**: Creates a bucket named "yash-singhal-terraform" - customize as needed

## Customization

### Change VPC CIDR
Modify the `variables.tf` file:
```hcl
variable "cidr" {
  default = "192.168.0.0/16"  # Your preferred CIDR
}
```

### Change Region
Update `provider.tf`:
```hcl
provider "aws" {
  region = "us-west-2"  # Your preferred region
}
```

### Modify Instance Type
Update `main.tf`:
```hcl
resource "aws_instance" "webserver1" {
  instance_type = "t3.small"  # Your preferred instance type
  # ... other configuration
}
```

## 🆘 Troubleshooting

### ⚠️ Challenges I Faced
1. **Route Table Not Enabling Internet Access**: Fixed by adding a default route (`0.0.0.0/0`) to the Internet Gateway and associating it with both subnets.  
2. **Userdata Scripts Not Installing Apache**: Fixed by adding `apt update` and `apt install -y apache2` at the start of the script.  
3. **Load Balancer Not Routing Traffic**: Fixed by attaching EC2 instances to the Target Group using `aws_lb_target_group_attachment` and verifying health checks.  
4. **Terraform ALB Creation Order Issue**: Fixed by directly using subnet IDs inside the Load Balancer configuration so Terraform could manage dependencies correctly.  


### Debug Commands
```bash
# Check Terraform state
terraform show

# Validate configuration
terraform validate

# Check provider status
terraform providers
```

## 📚 Additional Resources

- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS VPC Documentation](https://docs.aws.amazon.com/vpc/)
- [AWS Application Load Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/)

## 📄 License

MIT License © 2025 [Yash Singhal]