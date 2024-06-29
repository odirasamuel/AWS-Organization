data "aws_caller_identity" "current" {}
data "aws_caller_identity" "account1_1" {
    provider = aws.account1_1_alias
}


resource "aws_cloudtrail" "account1_1" {
  name = "account1-1"
  enable_logging = true
  s3_bucket_name = aws_s3_bucket.cloudtrail_audit.bucket
  s3_key_prefix = "audit"
  kms_key_id = aws_kms_key.cloudtrail_audit.arn
  enable_log_file_validation = true
  is_multi_region_trail = true
  include_global_service_events = true
  is_organization_trail true

  event_selector {
    read_write_type = "ALL"
    include_management_events = true

    data_resource {
        type = "AWS::Lambda::Function"
        values = ["arn:aws:lambda"]
    }
  }
}