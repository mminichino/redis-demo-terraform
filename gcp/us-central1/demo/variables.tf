#

variable "name" {
  type = string
}

variable "credential_file" {
  type = string
}

variable "project" {
  type = string
}

variable "region" {
  type = string
}

variable "regional_cluster" {
  type    = bool
  default = false
}

variable "node_count" {
  type    = number
  default = 4
}

variable "max_node_count" {
  type    = number
  default = 6
}

variable "cidr" {
  type = string
}

variable "gke_domain" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "public_key" {
  type = string
}

variable "gcs_state_bucket" {
  type = string
}
