# create s3 bucket
resource "aws_s3_bucket"  "mybucket" {

    bucket = "s3backend79939"
    versioning {
         enabled = true 
    }
    server_side_encryption_configuration {
         rule {
           apply_server_side_encryption_by_default {
          sse_algorithm = "AES256"
        }
      }
    }

}