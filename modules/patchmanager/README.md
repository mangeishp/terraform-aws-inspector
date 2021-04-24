# terraform-aws-ssm-patch-manger

A terraform module to deploy [AWS Systems Manager Patch Manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-patch.html)

## Prerequisites

* Create an IAM role for Systems Manager before launching your Amazon EC2 instance.
* Launch your Amazon EC2 instance with Amazon EBS and the IAM role for Systems Manager.
* SSM Agent for Linux [installed](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-install-ssm-agent.html) on EC2 instances.
* Add tags to the instances so that you can add your instances to a Systems Manager maintenance window based on tags.

## Usage

```terraform

module "ssmpatching" {
   source               = "../modules/patchmanager"
   common_tags          = var.common_tags
   patchbaseline_arn_id = "arn:aws:ssm:eu-north-1:035476931495:patchbaseline/pb-0c3d4afd9d8a36158"
   patchgroup           = "automatic"
   cron                 = "cron(0 0 20 ? * SUN *)"
   task                 = var.task
}

```
### Variables
###### General variables
 - `source` - The source path to the terraform module, see <a href="https://www.terraform.io/docs/modules/sources.html" target="_blank">here</a> for further information on the `source` variable. [*]

 - `name` - This value will prefix all resources, and be added as the value for the `Name` tag where supported. [*]

 - `envname` - This label will be added after `name` on all resources, and be added as the value for the `Environment` tag where supported. [*]

 - `envtype` - This label will be added after `envname` on all resources, and be added as the value for the `Envtype` tag where supported. [*]

###### Patch baseline variables
 - `approved_patches` - An explicit list of approved patches for the SSM baseline. [Default: []]

 - `rejected_patches` - An explicit list of rejected patches for the SSM baseline. [Default: []]

 - `product_versions` - An explicit list of rejected patches for the SSM baseline. [Default: []]

 - `product_versions` - The list of product versions for the SSM baseline. [Default: ["WindowsServer2016", "WindowsServer2012R2"]]

 - `patch_classification` - The list of patch classifications for the SSM baseline. [Default: ["CriticalUpdates", "SecurityUpdates"]]

 - `patch_severity` - The list of patch severities for the SSM baseline. [Default: ["Critical", "Important"]]

###### Maintenance Window variables
 - `scan_maintenance_window_schedule` - The schedule of the _scan_ Maintenance Window in the form of a cron or rate expression. You can find further information on the cron format <a href="https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-maintenance-cron.html" _target="blank">here</a>. [Default: "cron(0 0 18 ? * SUN *)"]

 - `install_maintenance_window_schedule` - The schedule of the _install_ Maintenance Window in the form of a cron or rate expression. You can find further information on the cron format <a href="https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-maintenance-cron.html" _target="blank">here</a>. [Default: "cron(0 0 21 ? * SUN *)"]

 - `maintenance_window_duration` - The duration of the _all_ Maintenance Windows in hours. [Default: "3"]

 - `maintenance_window_cutoff` - The number of hours before the end of any Maintenance Window that Systems Manager stops scheduling new tasks for execution. [Default: "1"]

 - `install_patch_groups` - The list of _install_ patching groups, one target will be created per entry in this list. [Default: ["automatic"]]

  - `scan_patch_groups` - The list of _scan_ patching groups, one target will be created per entry in this list. [Default: ["static", "disposable"]]