locals {
  org_primary_guardduty_detector_id = "***********************************"
}

module "account1_1" {
  source = "../modules/add_detector"
  alias = "account1-1"
  guardDutyEmail = "account1_1_email_address"
  primaryDetectorId = local.org_primary_guardduty_detector_id

  tags = {
    "org_unit" = "org-unit-1"
    "environment" = "dev"
  }

  providers = {
    aws = aws.account1_1_alias
   }
}

module "account2_1" {
  source = "../modules/add_detector"
  alias = "account2-1"
  guardDutyEmail = "account2_1_email_address"
  primaryDetectorId = local.org_primary_guardduty_detector_id

  tags = {
    "org_unit" = "org-unit-1"
    "environment" = "dev"
  }

  providers = {
    aws = aws.account2_1_alias
   }
}


module "account1_2" {
  source = "../modules/add_detector"
  alias = "account1-2"
  guardDutyEmail = "account1_2_email_address"
  primaryDetectorId = local.org_primary_guardduty_detector_id

  tags = {
    "org_unit" = "org-unit-2"
    "environment" = "dev"
  }

  providers = {
    aws = aws.account1_2_alias
   }
}

module "account2_2" {
  source = "../modules/add_detector"
  alias = "account2-2"
  guardDutyEmail = "account2_2_email_address"
  primaryDetectorId = local.org_primary_guardduty_detector_id

  tags = {
    "org_unit" = "org-unit-2"
    "environment" = "dev"
  }

  providers = {
    aws = aws.account2_2_alias
   }
}


module "account1_3" {
  source = "../modules/add_detector"
  alias = "account1-3"
  guardDutyEmail = "account1_3_email_address"
  primaryDetectorId = local.org_primary_guardduty_detector_id

  tags = {
    "org_unit" = "org-unit-3"
    "environment" = "dev"
  }

  providers = {
    aws = aws.account1_3_alias
   }
}

module "account2_3" {
  source = "../modules/add_detector"
  alias = "account2-3"
  guardDutyEmail = "account2_3_email_address"
  primaryDetectorId = local.org_primary_guardduty_detector_id

  tags = {
    "org_unit" = "org-unit-3"
    "environment" = "dev"
  }

  providers = {
    aws = aws.account2_3_alias
   }
}