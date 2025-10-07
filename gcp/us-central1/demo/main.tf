##

provider "google" {
  credentials = file(var.credential_file)
  project     = var.project
  region      = var.region
}

module "vpc" {
  source                = "git::https://github.com/mminichino/terraform.git//redis/gcp/modules/vpc?ref=v1.0.34"
  name                  = var.name
  cidr_block            = var.cidr
  gcp_project_id        = var.project
  gcp_region            = var.region
}

module "gke" {
  source                = "git::https://github.com/mminichino/terraform.git//redis/gcp/modules/gke?ref=v1.0.34"
  name                  = var.name
  regional_cluster      = var.regional_cluster
  node_count            = var.node_count
  max_node_count        = var.max_node_count
  gcp_project_id        = module.vpc.gcp_project_id
  gcp_region            = module.vpc.gcp_region
  network_name          = module.vpc.vpc_name
  subnet_name           = module.vpc.subnet_name
  gcp_zone_name         = var.gke_domain
  machine_type          = var.machine_type
  depends_on            = [module.vpc]
}

provider "helm" {
  kubernetes = {
    host                   = module.gke.cluster_endpoint_url
    token                  = module.gke.access_token
    cluster_ca_certificate = module.gke.cluster_ca_certificate
  }
}

provider "kubernetes" {
  host                   = module.gke.cluster_endpoint_url
  token                  = module.gke.access_token
  cluster_ca_certificate = module.gke.cluster_ca_certificate
}

module "gke_env" {
  source                 = "git::https://github.com/mminichino/terraform.git//redis/gcp/modules/gke_env?ref=v1.0.36"
  gke_domain_name        = module.gke.cluster_domain
  gke_storage_class      = module.gke.storage_class
  depends_on             = [module.gke]
}

module "argocd" {
  source                 = "git::https://github.com/mminichino/terraform.git//redis/gcp/modules/argocd?ref=v1.0.37"
  gke_domain_name        = module.gke.cluster_domain
  depends_on             = [module.gke_env]
}
