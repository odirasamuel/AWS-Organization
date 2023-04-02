#Create an organization called my_org_name
resource "aws_organizations_organization" "my_org_name" {
  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
  ]

  feature_set = "ALL"
}


#Create organizational units under the organization
resource "aws_organizations_organizational_unit" "org_unit_1" {
  name      = "org-unit-1"
  parent_id = aws_organizations_organization.my_org_name.roots[0].id
}

resource "aws_organizations_organizational_unit" "org_unit_2" {
  name      = "org-unit-2"
  parent_id = aws_organizations_organization.my_org_name.roots[0].id
}

resource "aws_organizations_organizational_unit" "org_unit_3" {
  name      = "org-unit-3"
  parent_id = aws_organizations_organization.my_org_name.roots[0].id
}