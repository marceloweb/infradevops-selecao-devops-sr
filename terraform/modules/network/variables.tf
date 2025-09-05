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