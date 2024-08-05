terraform {
  backend "s3" {
    bucket = "terrabucketstate"
    key    = "state/terraform.tfstate"
    region = "us-east-2"
  }
}