service_accounts = {
  sa_1 = {
    project_id = "platform-452421" 
    sa_name = "read-gcs-sa" 
    display_name = "read-gcs-sa" 
    description = "testing-purpose" 
    sa_users = [
      "user:satish@tecsolution.solutions"
    ] 
    iam_project_roles = [
      "roles/storage.admin"
    ] 
    prefix = "test"
  }
}
