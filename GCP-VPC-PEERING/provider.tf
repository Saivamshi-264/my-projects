provider "google" {
  project = var.project_id
  region  = var.region1
}

provider "google" {
  alias   = "region2"
  project = var.project_id
  region  = var.region2
}
