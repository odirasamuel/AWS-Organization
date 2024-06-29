provider "aws" {
  profile = "account1_1_profile"
  alias = "account1_1_alias"

  region = "us-east-2"

  default_tags {
    tags = {
        org_unit = "org-unit-1"
        environment = "dev"
    }
  }
}