# Terraform AWS Automation Project

A comprehensive Terraform infrastructure as code project that automates the deployment of a highly available web application on AWS with load balancing, auto-scaling capabilities, and multi-AZ deployment.

## 🏗️ Architecture Overview (With Best Practices)

This project creates a complete AWS infrastructure including:

- **VPC** with custom CIDR block (10.0.0.0/16)
- **Multi-AZ Subnets** discovered dynamically (no AZ letters hardcoded)
- **Internet Gateway** for public internet access
- **Route Tables** configured for public subnets
- **Security Groups** split for ALB and EC2; HTTP from internet to ALB, HTTP from ALB to EC2; SSH configurable
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

- [Terraform](https://www.terraform.io/downloads.html) >= 1.5
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- AWS account with permissions to create VPC, EC2, ALB, and S3 resources

## 🔧 Configuration

### AWS Provider
- **Region**: configurable via variable (`var.region`)
- **Provider Version**: ~> 5.11
- **Default Tags**: applied via provider to all resources (Project, Environment, Owner)

### Network Configuration
- **VPC CIDR**: 10.0.0.0/16
- **Subnet 1**: 10.0.0.0/24 (AZ index 0)
- **Subnet 2**: 10.0.1.0/24 (AZ index 1)

### Instance Configuration
- **AMI**: Amazon Linux 2023 (retrieved dynamically via SSM parameter)
- **Instance Type**: configurable via variable (`var.instance_type`), default t2.micro
- **Security Groups**: Allows HTTP (80) and SSH (22) access

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

![Terraform apply output](./images/apply-output.png)

## 🔒 Security Considerations

- Security groups are configured with minimal required access
- HTTP traffic is open for web access
- SSH access is available for administration
- All outbound traffic is allowed for updates and package installation

## 🚨 Important Notes

- **Cost**: Running t2.micro instances and ALB will incur AWS charges
- **Region**: Configurable via `var.region`
- **AMI**: Retrieved dynamically via SSM (no hardcoded AMI IDs)
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
Set in `variables.tf` or via CLI/environment:
```bash
# via CLI
terraform apply -var="region=us-west-2"

# or in a tfvars file
region = "us-west-2"
```

### Modify Instance Type
Set via variable:
```bash
terraform apply -var="instance_type=t3.small"
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