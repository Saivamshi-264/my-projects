output "cloud_function_url" {
  value = google_cloudfunctions_function.function.https_trigger_url
}
output "bucket_name" {
  value = google_storage_bucket.bucket.name
}
