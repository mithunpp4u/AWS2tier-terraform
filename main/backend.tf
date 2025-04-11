terraform {
  backend "s3" {
    bucket = "mithun-tfbackend-01"
    key    = "mithun3/10weeksofcloudops-demo.tfstate"
    region = "ap-south-1"
  }
}