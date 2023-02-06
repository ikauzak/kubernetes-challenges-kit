variable "cluster_location" {
  type        = string
  description = "Nome da localização do cluster e dos recursos"
  default     = null
}

variable "cluster_resource_group_name" {
  type        = string
  description = "Nome do resource group do cluster"
  default     = null
}

variable "vpc_addresses_space" {
  type        = list(string)
  description = "Lista com os endereços a serem criados na vpc"
  default     = ["10.1.0.0/16"]
}

variable "vpc_subnets" {
  type        = list(string)
  description = "Lista com os endereços de subnet a serem criados na vpc para atender o cluster"
  default     = ["10.1.0.0/22"]
}

variable "cluster_name" {
  type        = string
  description = "Nome do cluster a ser criado"
  default     = "mycluster"
}

variable "nodepool_vm_size" {
  type        = string
  description = "Tipo de vm do nodepool de sistema padrão"
  default     = "Standard_B4ms"
}

variable "nodepool_min_count" {
  type        = number
  description = "Minimo de nodes a serem criados no nodepool"
  default     = 1
}

variable "nodepool_max_count" {
  type        = number
  description = "Máximo de nodes a serem criados no nodepool"
  default     = 3
}
