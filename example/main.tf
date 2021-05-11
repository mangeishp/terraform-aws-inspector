provider "aws" {
  region = "eu-north-1"
}

module "my-inspector-deployment" {
  source                          = "../modules/inspector"
  name_prefix                     = "my-inspector"
  enable_scheduled_event          = true
  schedule_expression             = "rate(7 days)"
  ruleset_cve                     = true
  ruleset_cis                     = false
  ruleset_security_best_practices = true
  ruleset_network_reachability    = false
}

module "ssmpatching" {
  source = "../modules/patchmanager"
  #common_tags          = var.common_tags
  patchbaseline_arn_id = var.patchbaseline_arn_id
  patchgroup           = var.patchgroup
  cron                 = var.cron
  task                 = var.task
}
