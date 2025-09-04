data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

module "network_dev" {
  source = "../modules/network"

  project_name      = "comments-api"
  environment       = "dev"
  vpc_cidr          = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "comments_ecr_dev" {
  source = "../modules/ecr_repository"
  repository_name = var.repository_name
}

module "eks_dev" {
  source = "../modules/eks_cluster"

  cluster_name     = var.cluster_name
  cluster_role_arn = "arn:aws:iam::${local.account_id}:role/eks-role-dev"
  subnet_ids       = module.network_dev.private_subnet_ids
  instance_type    = var.instance_type
}