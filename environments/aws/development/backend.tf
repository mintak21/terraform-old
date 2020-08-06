terraform {
  # # use Terraform Cloud
  backend remote {
    hostname     = "app.terraform.io"
    organization = "mintak21"

    workspaces {
      name = "development"
    }
  }
}
