# Module 

This module of terraform allows you to create a RDS PostgreSQL instance. 

## Pre-Settings

- On your VPC AWS Dashboard, please tag at least 2 subnets with `type-subnet=public` due to create the **aws_db_subnet_group**
- Create your initial module configuration from ***module.tfvars.example***
- In the `main.tf` file please adjust your profile name in the **provider** section

## Execution 

Just run your plan/apply as below:

```
terraform plan -var-file=module.tfvars
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.74.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.74.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_subnet_group.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_security_group.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_all_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_all_access_ipv6](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_all_outbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_region.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_subnet_ids.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_vpc.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Boolean value to apply changes immediately. | `bool` | `false` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | The amount of days of backup retention. | `number` | `1` | no |
| <a name="input_backup_window"></a> [backup\_window](#input\_backup\_window) | The daily time range (in UTC) during which automated backups are created if they are enabled. | `string` | n/a | yes |
| <a name="input_copy_tags_to_snapshot"></a> [copy\_tags\_to\_snapshot](#input\_copy\_tags\_to\_snapshot) | Boolean value to copy all the tags from RDS to snapshots. | `bool` | `true` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Boolean value to enable deletion protection. | `bool` | `true` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | The RDS engine. | `string` | `"postgres"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The RDS engine version. | `string` | `"12.16"` | no |
| <a name="input_env"></a> [env](#input\_env) | The environmet name where RDS will be created. | `string` | n/a | yes |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | The instance\_class for RDS. | `string` | `"db.t4g.micro"` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | The window to perform maintenance in. [ddd:hh24:mi-ddd:hh24:mi] | `string` | n/a | yes |
| <a name="input_master_password"></a> [master\_password](#input\_master\_password) | The database master username's password. | `string` | n/a | yes |
| <a name="input_master_username"></a> [master\_username](#input\_master\_username) | The database master username. | `string` | n/a | yes |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval) | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. | `number` | `60` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | Boolean variable to specify if the RDS instance is multi-AZ (Multi available zones). | `bool` | `false` | no |
| <a name="input_project"></a> [project](#input\_project) | The project name. | `string` | n/a | yes |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | Boolean value to make RDS publicly accessible. | `bool` | `false` | no |
| <a name="input_service_port"></a> [service\_port](#input\_service\_port) | The RDS port to connect. | `number` | `5432` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Boolean value to skip final snapshot. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rds_endpoint"></a> [rds\_endpoint](#output\_rds\_endpoint) | The domain-name of the RDS endpoint |

# Copyright
Copyright © 2024 [Armando Uch](https://armanroot.com)
<!-- END_TF_DOCS -->
