module "ecr" {
  source = "./modules/ecr"
  repository_name = var.repository_name
}

module "bucket" {
  source = "./modules/s3"
  bucket_name = var.bucket_name
}
