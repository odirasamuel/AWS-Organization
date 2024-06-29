#Probably use account1_1 for gathering cloudtrial logs for audit purposes
data "aws_regions" "current" {
  all_regions = true
}

resource "aws_s3_bucket" "athena_query_cloudtrail" {
  provider = aws.account1_1_alias
  bucket = "athena-query-cloudtrail"
  force_destroy = true

}

# resource "aws_s3_bucket_acl" "athena_query_cloudtrail_bucket_acl" {
#   bucket = aws_s3_bucket.athena_query_cloudtrail.id
#   acl    = "private"
# }

resource "aws_s3_bucket_server_side_encryption_configuration" "threatIntel_bucket_encryption" {
  provider = aws.account1_1_alias
  bucket = aws_s3_bucket.athena_query_cloudtrail.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.guardduty_threat_intel.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "athena_query_cloudtrail" {
  provider = aws.account1_1_alias
  bucket = aws_s3_bucket.athena_query_cloudtrail.id
  versioning_configuration {
    status = "Enabled"
  }
}

data "aws_iam_policy_document" "access_local_and_iam_user" {
  statement {
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.account1_1.account_id}:root",
        "arn:aws:iam::${data.aws_caller_identity.account1_1.account_id}:role/OrganizationAccountAccessRole",
      ]
    }
    actions = [
      "s3:*"
    ]
    resources = [
      "arn:aws:s3:::athena-query-cloudtrail",
      "arn:aws:s3:::athena-query-cloudtrail/*"
    ]
  }
}


resource "aws_s3_bucket_policy" "access_local_and_iam_user" {
  provider = aws.account1_1_alias
  bucket = aws_s3_bucket.athena_query_cloudtrail.id
  policy = data.aws_iam_policy_document.access_local_and_iam_user.json
}

resource "aws_s3_bucket_public_access_block" "athena_query_cloudtrail" {
  provider = aws.account1_1_alias
  bucket = aws_s3_bucket.athena_query_cloudtrail.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_athena_workgroup" "cloudtrail_audit" {
  provider = aws.account1_1_alias
  name = "cloudtrail-audit"

  configuration {
    enforce_workgroup_configuration    = true
    publish_cloudwatch_metrics_enabled = true

    result_configuration {
      output_location = "s3://${aws_s3_bucket.athena_query_cloudtrail.bucket}/output/"

      encryption_configuration {
        encryption_option = "SSE_KMS"
        kms_key_arn       = aws_kms_key.example.arn
      }
    }
  }
}

resource "aws_glue_catalog_database" "cloudtrail" {
  provider = aws.account1_1_alias
  name = "cloudtrail-audit"
}

resource "aws_glue_catalog_table" "aws_glue_catalog_table" {
  provider = aws.account1_1_alias
  name          = "cloudtrail-audit"
  database_name = aws_glue_catalog_database.cloudtrail.name
  owner = "hadoop"

  table_type = "EXTERNAL_TABLE"

  parameters = {
    EXTERNAL              = "TRUE"
    "classification" = "cloudtrail"
    "comment" = "Cloudtrail table for ${aws_s3_bucket.cloudtrail_audit.bucket} bucket"
    "projection.enabled" = "true",
    "projection.account.type" = "enum",
    "projection.account.values" = join(",", [
        "123456789012",
        "123456789012",
        "123456789012",
        "123456789012",
        "123456789012",
        "123456789012",
    ])
    "projection.region.type" = "enum",
    "projection.region.values" = join(",", data.aws_regions.current.names)
    "projection.date.format" = "yyyy/MM/dd",
    "projection.date.interval" = "1",
    "projection.date.interval.unit" = "DAYS",
    "projection.date.range" = "2020/01/01,NOW",
    "projection.date.type" = "date",
    "starage.location.template" = "s3://${aws_s3_bucket.cloudtrail_audit.bucket}/audit/AWSLogs/o-pqa4qkd6pm/$${account}/CloudTrail/$${region}/$${date}"
  }

  partition_keys {
    name = "account"
    type = "string"
  }

  partition_keys {
    name = "region"
    type = "string"
  }

  partition_keys {
    name = "data"
    type = "string"
  }

  storage_descriptor {
    bucket_columns = []
    compressed = false
    location      = "s3://${aws_s3_bucket.cloudtrail_audit.arn}/audit/AWSLogs"
    number_of_buckets = -1
    input_format  = "com.amazon.emr.cloudtrail.CloudTrailInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"
    parameters = {}
    stored_as_sub_directories = false

    columns {
      name = "eventversion"
      type = "string"
    }

    columns {
      name = "userIdentity"
      type = "struct<type:string.principalId:string,arn:string,accountId:string,InvokedBy:string,accessKeyId:string,userName:string,sessionContext:struct<attributes:struct<mfaAuthenticated:string,creationDate:string>,sessionIssuer:struct<type:string,principalId:string,arn:string,accountId:string,userName:string>>>"
    }

    columns {
      name    = "eventtime"
      type    = "string"
    }

    columns {
      name    = "awsregion"
      type    = "string"
    }

    columns {
      name    = "sourceipaddress"
      type    = "string"
    }

    columns {
      name    = "useragent"
      type    = "string"
    }

    columns {
      name    = "errorcode"
      type    = "string"
    }

    columns {
      name    = "errormessage"
      type    = "string"
    }

    columns {
      name    = "requestparameters"
      type    = "string"
    }

    columns {
      name    = "responseelements"
      type    = "string"
    }

    columns {
      name    = "additionaleventdata"
      type    = "string"
    }

    columns {
      name    = "requestid"
      type    = "string"
    }

    columns {
      name    = "eventid"
      type    = "string"
    }

    columns {
      name    = "resources"
      type    = "array<struct<arn:string,accountId:string,type:string>>"
    }

    columns {
      name    = "eventtype"
      type    = "string"
    }

    columns {
      name    = "apiversion"
      type    = "string"
    }

    columns {
      name    = "readonly"
      type    = "string"
    }

    columns {
      name    = "recipientaccountid"
      type    = "string"
    }

    columns {
      name    = "sewrviceeventdetails"
      type    = "string"
    }

    columns {
      name    = "sharedeventid"
      type    = "string"
    }

    columns {
      name    = "vpcendpointid"
      type    = "string"
    }

    ser_de_info {
      serialization_library = "com.amazon.emr.hive.serde.CloudTrailSerde"

      parameters = {
        "serialization.format" = 1
      }
    }

  }
}