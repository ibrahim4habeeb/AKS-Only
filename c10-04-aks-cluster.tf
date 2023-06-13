# Provision AKS Cluster
/*
1. Add Basic Cluster Settings
  - Get Latest Kubernetes Version from datasource (kubernetes_version)
  - Add Node Resource Group (node_resource_group)
2. Add Default Node Pool Settings
  - orchestrator_version (latest kubernetes version using datasource)
  - availability_zones
  - enable_auto_scaling
  - max_count, min_count
  - os_disk_size_gb
  - type
  - node_labels
  - tags
3. Enable MSI
4. Add On Profiles 
  - Azure Policy
  - Azure Monitor (Reference Log Analytics Workspace id)
5. RBAC & Azure AD Integration
6. Admin Profiles
  - Windows Admin Profile
  - Linux Profile
7. Network Profile
8. Cluster Tags  
*/

resource "azurerm_kubernetes_cluster" "aks_backend_cluster" {
  name                = "aks-backend-cluster-cluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${azurerm_resource_group.rg.name}-cluster"
  kubernetes_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  private_cluster_enabled = true
  # node_resource_group = "${azurerm_resource_group.rg.name}-nrg"#azurerm_resource_group.rg.name

  default_node_pool {
    name                 = "user"
    node_count           = 1
    vm_size              = "Standard_DS2_v2"
    enable_auto_scaling = false
    orchestrator_version = data.azurerm_kubernetes_service_versions.current.latest_version
    # availability_zones   = [1, 2, 3]
    # enable_auto_scaling  = true
    # max_count            = 1
    # min_count            = 1
    # os_disk_size_gb      = 30
    vnet_subnet_id        = azurerm_subnet.snet3.id 
    node_labels = {
      "nodepool-type"    = "system"
      "environment"      = "dev"
      "nodepoolos"       = "linux"
      "app"              = "system-apps" 
    } 
   tags = {
      "nodepool-type"    = "system"
      "environment"      = "dev"
      "nodepoolos"       = "linux"
      "app"              = "system-apps" 
   } 
  }

# Identity (System Assigned or Service Principal)
  identity {
    type = "SystemAssigned"
  }

# Linux Profile
  linux_profile {
    admin_username = "azureuser"
    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }

# Network Profile
  network_profile {
    network_plugin = "azure"
    # load_balancer_sku = "Standard"
    # outbound_type = "userDefinedRouting"
    load_balancer_sku = "standard"
  }

  tags = {
    Environment = "dev"
  }
}
