module "credentials" {
  source = "../../modules/credentials"

  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

module "iam" {
  source = "../../modules/iam"

  cluster_name        = var.project_id
  iam_name            = format("%s%s", var.iam_name, title(var.project_id))
  eks_node_group_role = replace(format("%s%s", var.eks_node_group_role, title(var.project_id)), "-", "")
}

module "vpc" {
  source = "../../modules/vpc"

  vpc_name             = format("%s%s", "vpc-", var.project_id)
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
}

module "sub_network" {
  source = "../../modules/subnetwork"

  depends_on = [module.vpc]

  count = length(var.zones)

  vpc_id = module.vpc.vpc_id
  zones  = [var.zones[count.index]]

  public_cidr_block  = "11.32.${count.index + 1 * 2}.0/24"
  private_cidr_block = "11.32.${count.index + 2 * 4}.0/24"

  private_tags = {
    "kubernetes.io/cluster/${var.project_id}" = "owned"
    Name                                      = "${var.project_id}/SubnetPrivate${upper(replace(var.zones[count.index], "-", ""))}"
    "kubernetes.io/role/internal-elb"         = 1
  }
  public_tags = {
    "kubernetes.io/cluster/${var.project_id}" = "owned"
    Name                                      = "${var.project_id}/SubnetPublic${upper(replace(var.zones[count.index], "-", ""))}"
    "kubernetes.io/role/elb"                  = 1
  }
}

module "internet_gateway" {
  source = "../../modules/internet-gateway"

  vpc_id   = module.vpc.vpc_id
  vpc_name = format("%s%s", "igw-", var.project_id)
}

module "route_table" {
  source = "../../modules/route-table"

  depends_on = [module.sub_network]

  zones                   = var.zones
  vpc_id                  = module.vpc.vpc_id
  vpc_name                = format("%s%s", "rtb-", var.project_id)
  internet_gateway_id     = module.internet_gateway.internet_gateway_id
  public_subnet_ids       = concat([for subnet in module.sub_network : subnet.public_subnet_ids][*][0])
  private_subnet_ids      = [for subnet in module.sub_network : subnet.private_subnet_ids][*][0]
  private_route_table_ids = module.route_table.private_route_table_ids
  cidr_block              = var.route_table_cidr_block
}

module "nat_gateway" {
  source = "../../modules/nat-gateway"

  depends_on = [module.sub_network]

  vpc_id                  = module.vpc.vpc_id
  vpc_name                = format("%s%s", "nat-", var.project_id)
  public_subnet_id        = module.sub_network[0].public_subnet_ids[0]
  private_route_table_ids = module.route_table.private_route_table_ids
  destination_cidr_block  = var.destination_cidr_block
}

module "cw_log_group" {
  source = "../../modules/cloud-watch"

  cluster_name      = var.project_id
  retention_in_days = var.retention_in_days
}

module "eks" {
  source = "../../modules/eks"

  depends_on = [module.iam, module.sub_network, module.cw_log_group]

  cluster_name       = var.project_id
  role_arn           = module.iam.iam_role_arn
  subnet_ids         = concat([for subnet in module.sub_network : subnet.private_subnet_ids][*][0], [for subnet in module.sub_network : subnet.public_subnet_ids][*][0])
  eks_log_types      = var.eks_log_types
  aws_auth_configmap = local.aws_auth_configmap
}

module "node_group" {
  source = "../../modules/node-group"

  depends_on = [module.eks]

  cluster_name    = var.project_id
  node_role_arn   = module.iam.iam_role_eks_ng_arn
  disk_size       = var.disk_size
  subnet_ids      = [for subnet in module.sub_network : subnet.public_subnet_ids][*][0]
  node_group_name = format("%s%s", "ng-", var.project_id)
  ami_type        = var.ami_type
  instance_types  = var.instance_types
  scaling_config  = var.scaling_config
}

module "plugins" {
  source = "../../modules/plugins"

  region                        = var.region
  cluster_certificate           = module.eks.cluster_certificate_authority
  cluster_token                 = module.eks.cluster_token
  oicd_issuer                   = module.eks.identity_oidc_issuer
  cluster_endpoint              = module.eks.cluster_endpoint
  cluster_id                    = module.eks.cluster_id
  cluster_certificate_authority = module.eks.cluster_certificate_authority
  nodes_name                    = module.iam.eks_ng_role_name
  roles                         = local.roles
  argocd-configmap              = local.argocd.configmap
  argocd-rbac                   = local.argocd.rbac
  karpenter                     = local.karpenter
}
