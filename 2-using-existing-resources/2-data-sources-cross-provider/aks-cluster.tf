provider "azurerm" {
  version = "=1.36.1"
}

# Documentation on the Kubernetes Data Source: https://terraform.io/docs/providers/azurerm/d/kubernetes_cluster.html
data "azurerm_kubernetes_cluster" "existing" {
  name                = "tom-buildstuff-k8s"
  resource_group_name = "tom-buildstuff-resources"
}

/*
The KubeConfig can be returned by calling:

```
az aks get-credentials --resource-group tom-buildstuff-resources --name tom-buildstuff-k8s
```

Once that's done - the Kubernetes Dashboard can then be seen by running:

```
az aks browse --resource-group tom-buildstuff-resources --name tom-buildstuff-k8s
```
*/
