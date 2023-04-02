#Create accounts under each organizational units

#--------------------------------------------------------------------------------------------------
#Account1 under the organizational unit 1
resource "aws_organizations_account" "account1_1" {
  name  = "account1_1"
  email = "account1_1_email@domain.com"
  parent_id = aws_organizations_organizational_unit.org_unit_1.id
  tags = {
    "org_unit" = "org-unit-1"
    "environment" = "dev"
  }
}

#Account2 under the organizational unit 1
resource "aws_organizations_account" "account2_1" {
  name  = "account2_1"
  email = "account2_1_email@domain.com"
  parent_id = aws_organizations_organizational_unit.org_unit_1.id
  tags = {
    "org_unit" = "org-unit-1"
    "environment" = "dev"
  }
}

#--------------------------------------------------------------------------------------------------
#Account1 under the organizational unit 2
resource "aws_organizations_account" "account1_2" {
  name  = "account1_2"
  email = "account1_2_email@domain.com"
  parent_id = aws_organizations_organizational_unit.org_unit_2.id
  tags = {
    "org_unit" = "org-unit-2"
    "environment" = "dev"
  }
}

#Account2 under the organizational unit 2
resource "aws_organizations_account" "account2_2" {
  name  = "account2_2"
  email = "account2_2_email@domain.com"
  parent_id = aws_organizations_organizational_unit.org_unit_2.id
  tags = {
    "org_unit" = "org-unit-2"
    "environment" = "dev"
  }
}

#-------------------------------------------------------------------------------------------------
#Account1 under the organizational unit 3
resource "aws_organizations_account" "account1_3" {
  name  = "account1_3"
  email = "account1_3_email@domain.com"
  parent_id = aws_organizations_organizational_unit.org_unit_3.id
  tags = {
    "org_unit" = "org-unit-3"
    "environment" = "dev"
  }
}

#Account2 under the organizational unit 3
resource "aws_organizations_account" "account2_3" {
  name  = "account2_3"
  email = "account2_3_email@domain.com"
  parent_id = aws_organizations_organizational_unit.org_unit_3.id
  tags = {
    "org_unit" = "org-unit-3"
    "environment" = "dev"
  }
}