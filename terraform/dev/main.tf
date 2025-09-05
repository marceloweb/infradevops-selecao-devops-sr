terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    helm = {
      source = "hashicorp/helm"
    }
  }
}

provider "kubernetes" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}

provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}

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

module "iam_role" {
  source = "../modules/iam"
  role_name = "eks-role-dev"
}

module "eks_dev" {
  source = "../modules/eks_cluster"

  cluster_name     = var.cluster_name
  cluster_role_arn = module.iam_role.arn
  subnet_ids       = module.network_dev.private_subnet_ids
  instance_type    = var.instance_type
  desired_size     = 2
  min_size         = 1
  max_size         = 3
}

resource "null_resource" "update_kubeconfig" {
  depends_on = [module.eks_dev]

  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${module.eks_dev.cluster_name} --region ${var.aws_region}"
  }
}

module "argocd" {
  source = "../modules/argocd"

  providers = {
    helm        = helm
    kubernetes  = kubernetes
  }

  depends_on = [null_resource.update_kubeconfig]
}

module "rds" {
  source = "../modules/rds"

  environment = var.environment
  vpc_id      = module.network.vpc_id
  subnet_ids  = module.network.private_subnet_ids
  db_username = "postgres"
  db_password = var.db_password
  db_name     = "comments_db"
  eks_cluster_security_group_id = module.eks_cluster.cluster_security_group_id
}