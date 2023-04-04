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

provider "aws" {
  profile = "account2_1_profile"
  alias = "account2_1_alias"

  region = "us-east-2"

  default_tags {
    tags = {
        org_unit = "org-unit-1"
        environment = "dev"
    }
  }
}

provider "aws" {
  profile = "account1_2_profile"
  alias = "account1_2_alias"

  region = "us-east-2"

  default_tags {
    tags = {
        org_unit = "org-unit-2"
        environment = "dev"
    }
  }
}

provider "aws" {
  profile = "account2_2_profile"
  alias = "account2_2_alias"

  region = "us-east-2"

  default_tags {
    tags = {
        org_unit = "org-unit-2"
        environment = "dev"
    }
  }
}

provider "aws" {
  profile = "account1_3_profile"
  alias = "account1_3_alias"

  region = "us-east-2"

  default_tags {
    tags = {
        org_unit = "org-unit-3"
        environment = "dev"
    }
  }
}

provider "aws" {
  profile = "account2_3_profile"
  alias = "account2_3_alias"

  region = "us-east-2"

  default_tags {
    tags = {
        org_unit = "org-unit-3"
        environment = "dev"
    }
  }
}