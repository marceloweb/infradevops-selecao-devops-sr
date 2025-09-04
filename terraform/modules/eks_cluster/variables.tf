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

variable "instance_type" {
  description = "The EC2 instance type for the EKS worker nodes"
  type        = string
}