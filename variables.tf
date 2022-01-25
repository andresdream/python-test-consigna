variable "stack_id" {
  description = "Nombre del ambiente"
  type        = string
}

variable "layer" {
  description = "Nombre del proyecto"
  type        = string
}

variable "type" {
  description = "Tipo del recurso, infra, frontend, movil, backend"
  type        = string
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS Region"
}

variable "app_port" {
  default = "80"
}

variable "az_count" {
  default = "3"
}

variable "fargate_cpu" {
  default = "256"
}

variable "fargate_memory" {
  default = "512"
}

variable "app_count" {
  default = "2"
}

variable "vpc" {
  type        = string
  description = "VPC"
}

variable "subnet_private1" {
  type        = string
  description = "Subnet private1"
}

variable "subnet_private2" {
  type        = string
  description = "Subnet private2"
}

variable "subnet_private3" {
  type        = string
  description = "Subnet private3"
}

variable "subnet_public1" {
  type        = string
  description = "Subnet public1"
}

variable "subnet_public2" {
  type        = string
  description = "Subnet public2"
}

variable "subnet_public3" {
  type        = string
  description = "Subnet public3"
}

variable "service_fargate_python" {
  default = "java-python"
}

/*
VARIABLE DE TASK
*/


variable "task_definition_python" {
  default = "java-python-tsk"
}