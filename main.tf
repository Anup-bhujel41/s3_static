# main configuration file where we will reference the vpc module

#configure aws provider
provider "aws" {
  region = var.region

}




#creating s3 for static hosting
module "s3" {
  source      = "./s3"
  bucket_name = var.bucket_name
}

# module "templete_files" {
#   source = "/home/darkwhit33/Desktop/projects/s3_static/s3_static/"

#   base_dir = "${path.module}/darkness"
# }