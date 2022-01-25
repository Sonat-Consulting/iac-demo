variable "rg" {
  description = "The resource group to apply the infrastructure"
  type        = string
}

variable "app_plan_tier" {
    type = string
}

variable "app_plan_size" {
    type = string
}

variable "env_prefix" {
    type = string
}

variable "location" {
    type = string
}