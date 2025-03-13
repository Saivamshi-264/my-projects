terraform {
  backend "gcs" {
    bucket = tf-state-gce-sa-statefile  # replace this with the bucket name you want to store your remote state
    prefix = g  # replace this with the state file prefix inside the bucket
  }
}


# variables don't work for terraform backend.tf . You'll have to incorporate the values accordingly 