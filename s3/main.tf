# resource for hosting s3 for static hosting
data "aws_s3_bucket" "existing_bucket" {
  bucket = "1234ecommerce56789"
}

#creating access control for the s3 bucket
resource "aws_s3_bucket_acl" "static_hosting_acl" {
  bucket = data.aws_s3_bucket.existing_bucket.id
  acl    = "public-read"

}

#creating bucket policy
resource "aws_s3_bucket_policy" "static_hosting_policy" {
  bucket = data.aws_s3_bucket.existing_bucket.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "s3:GetObject",
        "Resource" : "arn:aws:s3:::1234ecommerce56789/*"
      }
    ]
  })
}

#static website hosting on the s3 bucket
resource "aws_s3_bucket_website_configuration" "static_hosting_website_configuration" {
  bucket = data.aws_s3_bucket.existing_bucket.id

  index_document {
    suffix = "index.html"
  }
}


# uploading the files on the s3 bucket
# resource "aws_s3_object" "static_hosting_files" {
#   bucket       = aws_s3_bucket.static_hosting.id
#   for_each     = module.templete_files.files
#   key          = each.key
#   content_type = each.value.content_type
#   source       = "${module.templete_files.base_dir}/${each.key}"
#   content      = each.value.content
#   etag         = each.value.digests.md5
# }

