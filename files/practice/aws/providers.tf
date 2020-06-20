terraform {
  required_version = ">=0.12"
}

provider aws {
  version = ">=2.67.0"
  region  = "ap-northeast-1" # required
  profile = "mintak-terraform"
}
