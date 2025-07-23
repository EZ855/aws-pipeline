// main Terraform configuration
provider "aws" {
  region = var.region
}

module "s3" {
  source = "./glue"
}
