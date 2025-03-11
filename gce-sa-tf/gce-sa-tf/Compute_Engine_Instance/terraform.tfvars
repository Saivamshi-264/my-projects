vm_config = {
  test-instance-gcs-read = {
    project_id = "platform-452421" 
    name = "test-instance-gcs-read" 
    zone = "asia-south1-a" 
    description = "" 
    instance_type = "e2-micro" 
    network_tags = [
    ] 
    labels = {
    },
    vpc = "testcis" 
    subnet = "testcis" 
    sa_email = "" 
    boot_disk_image = "projects/debian-cloud/global/images/family/debian-11" 
    boot_disk_type = "pd-standard" 
    boot_disk_size = 20
  }
}
