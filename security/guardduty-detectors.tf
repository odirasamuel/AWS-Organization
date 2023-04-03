resource "aws_guardduty_detector" "MyDetector" {
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

output "primaryDetectorId" {
  value = aws_guardduty_detector.MyDetector.id
}