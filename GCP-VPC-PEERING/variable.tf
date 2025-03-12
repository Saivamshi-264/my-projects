variable "project_id" {
  description = "platform-452421"
  type        = string
}

variable "region1" {
  description = "Primary VPC Region"
  type        = string
  default     = "asia-east1"
}

variable "region2" {
  description = "Secondary VPC Region"
  type        = string
  default     = "asia-northeast1"
}

variable "vpc1_name" {
  description = "mypeering-01"
  type        = string
  default     = "vpc-1"
}

variable "vpc2_name" {
  description = "mypeering-02"
  type        = string
  default     = "vpc-2"
}
