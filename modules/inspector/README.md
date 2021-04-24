# terraform-aws-inspector

A terraform module to deploy [Amazon Inspector](https://docs.aws.amazon.com/inspector/latest/userguide/inspector_introduction.html)

## Prerequisites

* Amazon Inspector Agent [installed](https://docs.aws.amazon.com/inspector/latest/userguide/inspector_installing-uninstalling-agents.html#install-linux) on desired EC2 instances.
* Amazon Inspector [Region-Specific ARNs](https://docs.aws.amazon.com/inspector/latest/userguide/inspector_rules-arns.html) for rules packages.

## Usage

### Variables

#### Required

* `name_prefix` - Used as a prefix for resources created in AWS.

#### Optional

* `enable_scheduled_event` - Default `true`; A way to disable Inspector from running on a schedule
* `schedule_expression` - Default `rate(7 days)`; How often to run an Inspector assessment. See [AWS Schedule Expression documentation](https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html) for more info on formatting.s
* `assessment_duration` - Default `3600`; How long the assessment runs in seconds.
* `ruleset_cve` - Default `true`; Includes the Common Vulnerabilties and Exposures [ruleset](https://docs.aws.amazon.com/inspector/latest/userguide/inspector_rule-packages.html) in the Inspector assessment.
* `ruleset_cis` - Default `true`; Includes the CIS Benchmarks [ruleset](https://docs.aws.amazon.com/inspector/latest/userguide/inspector_rule-packages.html) in the Inspector assessment.
* `ruleset_security_best_practices` - Default `true`; Includes the AWS Security Best Practices [ruleset](https://docs.aws.amazon.com/inspector/latest/userguide/inspector_rule-packages.html) in the Inspector assessment.
* `ruleset_network_reachability` - Default `true`; Includes the Network Reachability [ruleset](https://docs.aws.amazon.com/inspector/latest/userguide/inspector_rule-packages.html) in the Inspector assessment.

### Simple Example

It doesn't take much to get off the ground with this module. All you need to get started scanning is this:

```terraform
module "my-inspector-deployment" {
  source      = "../modules/inspector"
  name_prefix = "my-inspector"
}
```