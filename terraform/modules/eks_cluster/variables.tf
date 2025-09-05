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

variable "min_size" {
  description = "Minimum number of worker nodes in the cluster"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of worker nodes in the cluster"
  type        = number
  default     = 3
}

variable "desired_size" {
  description = "Desired number of worker nodes in the cluster"
  type        = number
  default     = 2
}

