# Create a Cloud Storage bucket
resource "google_storage_bucket" "bucket" {
  name     = var.bucket_name
  location = var.region

    # Enable Uniform Bucket-Level Access
  uniform_bucket_level_access = true
}

# Package Cloud Function code
data "archive_file" "function_source" {
  type        = "zip"
  source_dir  = "${path.module}/function_source"
  output_path = "${path.module}/function_source.zip"
}

# Upload code package to the bucket
resource "google_storage_bucket_object" "function_code" {
  name   = "function_source.zip"
  bucket = google_storage_bucket.bucket.name
  source = data.archive_file.function_source.output_path
}

resource "google_service_account" "function_sa" {
  account_id   = "file-upload-logge-sa"
  display_name = "Cloud Function Service Account"
}
 
resource "google_project_iam_member" "function_logging" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.function_sa.email}"
}


# Create Cloud Function
resource "google_cloudfunctions_function" "function" {
  name                  = var.function_name
  runtime               = "python311"
  region                = var.region
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.function_code.name
  entry_point           = "file_upload_trigger"
  service_account_email = google_service_account.function_sa.email

  event_trigger {
    event_type = "google.storage.object.finalize"
    resource   = google_storage_bucket.bucket.name
  }
}
