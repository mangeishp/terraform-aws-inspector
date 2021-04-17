
resource "aws_ssm_patch_baseline" "amazon_linux_2" {
  name             = "${var.environment}-amazon-linux-2"
  description      = "My patch repository for Amazon Linux 2"
  operating_system = "AMAZON_LINUX_2"

  approval_rule {
    approve_after_days = 7
    patch_filter {
      key    = "PRODUCT"
      values = ["AmazonLinux2", "AmazonLinux2.0"]
    }
    patch_filter {
      key    = "CLASSIFICATION"
      values = ["Security"]
    }
    patch_filter {
      key        = "SEVERITY"
      valuvalues = ["Critical"]
    }
  }
}

resource "aws_ssm_patch_group" "proxy" {
  baseline_id = aws_ssm_patch_baseline.amazon_linux_2.id
  patch_group = "${var.environment}-proxy"
}
