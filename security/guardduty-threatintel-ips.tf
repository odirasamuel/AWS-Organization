resource "aws_guardduty_ipset" "ipSet" {
  activate    = true
  detector_id = aws_guardduty_detector.MyDetector.id
  format      = "TXT"
  location    = "https://s3.amazonaws.com/${aws_s3_object.ThreatIntelIps.bucket}/${aws_s3_object.ThreatIntelIps.key}"
  name        = "ThreatIntelIps"
}

resource "aws_s3_object" "ThreatIntelIps" {
  content = "10.0.0.0/8\n"
  bucket  = aws_s3_bucket.threatIntel.id
  key     = "CustomThreatIntelList"
  acl = "public-read"

  depends_on = [
    aws_s3_bucket.threatIntel
  ]
}