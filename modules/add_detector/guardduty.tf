resource "aws_guardduty_detector" "member" {
  count = var.primaryDetectorId != "" ? 1 : 0
  enable = true

  datasources {
    s3_logs {
      enable = true
    }
    malware_protection {
      scan_ec2_instance_with_findings {
        ebs_volumes {
          enable = true
        }
      }
    }
  }
  finding_publishing_frequency = "FIFTEEN_MINUTES"
}