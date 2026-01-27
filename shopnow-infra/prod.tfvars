# Environment
region = "eu-west-3"

eks_cluster_name    = "sam-eks-cluster"
eks_cluster_version = "1.33"

account     = "shopnow"
environment = "prod"

vpc_cni_role_name = "AmazonEKSVPCCNIRole-sam-eks-cluster"
aws_lbc_role_name = "aws-lbc-sam-eks-cluster"

# VPC configuration
vpc_name = "sam-shopnow-vpc"
vpc_cidr = "10.0.0.0/16"

azs = [
  "eu-west-2a",
  "eu-west-2b"
]

private_subnets = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

public_subnets = [
  "10.0.101.0/24",
  "10.0.102.0/24"
]

# Common tags
tags = {
  Environment = "prod"
  Project     = "eks"
  Owner       = "Sam"
  ManagedBy   = "terraform"
}
