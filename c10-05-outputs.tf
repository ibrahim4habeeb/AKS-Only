# Azure AKS Outputs

output "aks_cluster_id" {
  value = azurerm_kubernetes_cluster.aks_backend_cluster.id
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks_backend_cluster.name
}

output "aks_cluster_kubernetes_version" {
  value = azurerm_kubernetes_cluster.aks_backend_cluster.kubernetes_version
}
