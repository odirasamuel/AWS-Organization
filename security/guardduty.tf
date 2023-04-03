#Define the organizational level Guardduty master and local detector
#Invite child accounts to the org-level guard duty

data "aws_organizations_organization" "my_org_name" {}

resource "aws_guardduty_organization_admin_account" "example" {
  depends_on = [
    data.aws_organizations_organization.my_org_name,
    aws_s3_bucket.threatIntel
    
    ]

  admin_account_id = data.aws_organizations_organization.my_org_name.master_account_id
}