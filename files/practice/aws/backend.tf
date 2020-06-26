terraform {
  # use AWS S3 Bucket
  /* backend s3 {
    bucket         = "mintak-tfstate-manage"
    key            = "mintak-terraformer/terraform.tfstate"
    dynamodb_table = "mintak-terraform-tfstate-lock"
    region         = "ap-northeast-1"
    encrypt        = true
  } */

  # use Terraform Cloud
  backend remote {
    hostname     = "app.terraform.io"
    organization = "mintak21"

    workspaces {
      name = "terraform"
    }
  }
}
