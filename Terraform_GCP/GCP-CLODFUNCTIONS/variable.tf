variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The region where resources will be deployed"
  type        = string
  default     = "us-central1"
}

variable "bucket_name" {
  description = "Name of the Cloud Storage bucket"
  type        = string
  default     = "file-upload-trigger-bucket"
}

variable "function_name" {
  description = "Name of the Cloud Function"
  type        = string
  default     = "file-upload-logger"
}


