resource "google_storage_bucket" "my_bucket" {
  name          = var.bucket_name
  location      = var.region
  storage_class = "STANDARD"

  uniform_bucket_level_access = true  # Enable UBLA as per policy

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type          = "SetStorageClass"
      storage_class = "COLDLINE"  # Equivalent to AWS Glacier
    }
    condition {
      age = 60  # Move to Coldline storage after 60 days
    }
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 365  # Delete objects after 365 days
    }
  }
}
