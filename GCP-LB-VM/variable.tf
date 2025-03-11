variable "project_id" {
  description = "platform-452421"
  type        = string
}

variable "region" {
  description = "us-central1"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Zone for the deployment"
  type        = string
  default     = "us-central1-a"
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 2
}
