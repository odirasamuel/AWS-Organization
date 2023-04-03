locals {
  guardduty_threat_intel_bucket_name = "guardduty-threat-intel"
}

resource "aws_kms_key" "guardduty_threat_intel" {
  description = "Encryption key for Guardduty threatintel set"
  deletion_window_in_days = 30
  enable_key_rotation = true
  tags = {
    Name = local.guardduty_threat_intel_bucket_name
  }
}

resource "aws_s3_bucket" "threatIntel" {
  bucket = local.guardduty_threat_intel_bucket_name
  force_destroy = true

  tags = {
    Name = local.guardduty_threat_intel_bucket_name
  }
}

resource "aws_s3_bucket_acl" "threatIntel_bucket_acl" {
  bucket = aws_s3_bucket.threatIntel.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "threatIntel_bucket_encryption" {
  bucket = aws_s3_bucket.threatIntel.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.guardduty_threat_intel.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "threatIntel_bucket_versioning" {
  bucket = aws_s3_bucket.threatIntel.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "threatIntel" {
  bucket = aws_s3_bucket.threatIntel.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}