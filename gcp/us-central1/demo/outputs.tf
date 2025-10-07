#

output "grafana_admin_password" {
  description = "Grafana admin password"
  value       = module.gke_env.grafana_admin_password
  sensitive   = true
}

output "argocd_password" {
  description = "ArgoCD Admin Password"
  value       = module.argocd.admin_password
  sensitive   = true
}

output "grafana_ui" {
  description = "Grafana UI URL"
  value       = module.gke_env.grafana_ui
}

output "argocd_ui" {
  description = "ArgoCD UI URL"
  value       = module.argocd.argocd_ui
}
