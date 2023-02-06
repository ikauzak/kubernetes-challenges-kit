resource "azurerm_resource_group" "main" {
  name     = var.cluster_resource_group_name
  location = var.cluster_location
}

resource "azurerm_virtual_network" "main_network" {
  name                = "aks-network"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = var.vpc_addresses_space
}

resource "azurerm_subnet" "internal" {
  name                 = "aks-internal-subnets"
  virtual_network_name = azurerm_virtual_network.main_network.name
  resource_group_name  = azurerm_resource_group.main.name
  address_prefixes     = var.vpc_subnets
}

resource "azurerm_public_ip" "main-ext-ip" {
  name                = "main-gateway-ip"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "main-gateway" {
  name                = "main-nat-gateway"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku_name            = "Standard"
}

resource "azurerm_nat_gateway_public_ip_association" "main-association" {
  nat_gateway_id       = azurerm_nat_gateway.main-gateway.id
  public_ip_address_id = azurerm_public_ip.main-ext-ip.id
}

resource "azurerm_subnet_nat_gateway_association" "main-subnet-association" {
  subnet_id      = azurerm_subnet.internal.id
  nat_gateway_id = azurerm_nat_gateway.main-gateway.id
}

resource "azurerm_network_security_group" "main-nsg" {
  name                = "main-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_network_security_rule" "outbound" {
  name                        = "outbound-rule"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_address_prefix       = "*"
  destination_port_range      = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.main-nsg.name
}

resource "azurerm_network_security_rule" "inbound" {
  name                        = "inbound-rule"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_address_prefix       = "*"
  destination_port_range      = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.main-nsg.name
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = var.cluster_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = var.cluster_name

  default_node_pool {
    name                = "system"
    vm_size             = var.default_nodepool_vm_size
    vnet_subnet_id      = azurerm_subnet.internal.id
    enable_auto_scaling = true
    max_count           = var.nodepool_max_count
    min_count           = var.nodepool_min_count
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

