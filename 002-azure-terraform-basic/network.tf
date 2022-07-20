resource "azurerm_resource_group" "k8s-desafio" {
  name     = "k8s-desafio-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "k8s-desafio" {
  name                = "k8s-desafio-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.k8s-desafio.location
  resource_group_name = azurerm_resource_group.k8s-desafio.name
}

resource "azurerm_subnet" "k8s-desafio" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.k8s-desafio.name
  virtual_network_name = azurerm_virtual_network.k8s-desafio.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "k8s-desafio" {
  name                = "k8s-desafio-nic"
  location            = azurerm_resource_group.k8s-desafio.location
  resource_group_name = azurerm_resource_group.k8s-desafio.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.k8s-desafio.id
    private_ip_address_allocation = "Dynamic"
  }
}