resource "aws_iam_account_alias" "alias_default" {
    count = lenght(var.alias) > 0 ? 1 : 0
    account_alias = var.alias  
}