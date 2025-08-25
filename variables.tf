variable "cidr" {
  default = "10.0.0.0/16"
}

variable "region" {
  type        = string
  description = "AWS region to deploy resources into"
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "Deployment environment name"
  default     = "dev"
}

variable "owner" {
  type        = string
  description = "Owner or team responsible for these resources"
  default     = "yash"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type for web servers"
  default     = "t2.micro"
}