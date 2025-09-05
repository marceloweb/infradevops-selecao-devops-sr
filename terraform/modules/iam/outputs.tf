output "arn" {
  description = "The ARN of the IAM role"
  value       = aws_iam_role.eks_node_role.arn
}