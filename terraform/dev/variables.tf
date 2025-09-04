variable cluster_name {
  type        = string
  description = "description"
}

variable cluster_role_arn {
  type        = string
  description = "description"
}

variable subnet_ids {
  type        = list(string)
  description = "description"
}

variable repository_name {
  type        = string
  description = "description"  
}

variable "project_name" {
  type = string
  description = "description"    
}

variable "environment" {
  type = string
  description = "description"    
}

variable "vpc_cidr" {
  type = string
  description = "description"    
}

variable "public_subnet_cidrs" {
  description = "A list of CIDR blocks for the public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "A list of CIDR blocks for the private subnets"
  type        = list(string)
}

variable "instance_type" {
  description = "The EC2 instance type for the EKS worker nodes"
  type        = string
}
