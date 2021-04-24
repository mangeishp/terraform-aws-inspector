
variable "patchgroup" {
  type        = string
  description = "A named group of servers to apply tasks to"
  default     = "automatic"
}

variable "patchbaseline_arn_id" {
  type        = string
  description = "This is an AWS variable that describe the patch baseline"
  default     = "arn:aws:ssm:eu-north-1:035476931495:patchbaseline/pb-0c3d4afd9d8a36158"
}

variable "cron" {
  type        = string
  description = "The Cron statement to control the patch schedule"
  default     = "cron(0 0 08 ? * SUN *)"
}

variable "task" {
  description = "Contains the task details and command"
  default = {
    name   = "commands"
    values = ["yum update -y; reboot"]
  }
}
