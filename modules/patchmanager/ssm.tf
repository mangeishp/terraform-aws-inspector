##################################
# SSM Maintenance Window Target
##################################
resource "aws_ssm_maintenance_window_target" "target" {
  window_id     = aws_ssm_maintenance_window.production.id
  resource_type = "INSTANCE"

  targets {
    key    = "tag:Patch Group"
    values = [var.patchgroup]
  }
}

##################################
# SSM Maintenance Window
##################################

resource "aws_ssm_maintenance_window" "production" {
  name     = var.patchgroup
  schedule = var.cron
  duration = 3
  cutoff   = 1
  enabled  = true
}

##################################
# SSM Maintenance Window Task
##################################

resource "aws_ssm_maintenance_window_task" "task" {
  window_id        = aws_ssm_maintenance_window.production.id
  task_type        = "RUN_COMMAND"
  task_arn         = "AWS-RunShellScript"
  priority         = 1
  service_role_arn = aws_iam_role.patchaccess.arn
  max_concurrency  = "2"
  max_errors       = "1"

  targets {
    key    = "InstanceIds"
    values = [aws_ssm_maintenance_window.production.id]
  }

  task_invocation_parameters {
    run_command_parameters {
      parameter {
        name   = var.task["name"]
        values = var.task["values"]
      }
    }
  }
}

##################################
# SSM Patchgroup 
##################################

resource "aws_ssm_patch_group" "patchgroup" {
  baseline_id = var.patchbaseline_arn_id
  patch_group = var.patchgroup
}

##################################
# SSM Patchgroup 
##################################

