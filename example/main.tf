provider "aws" {
  region = "eu-north-1"
}

module "my-inspector-deployment" {
  source = "../modules/inspector"
  name_prefix                     = "my-inspector"
  enable_scheduled_event          = true
  schedule_expression             = "cron(0 14 * * ? *)"
  ruleset_cve                     = true
  ruleset_cis                     = false
  ruleset_security_best_practices = true
  ruleset_network_reachability    = false
}
