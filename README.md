# Terraform ECS

## Module deployment pre-requisites

For module ecs_task_alb, first deploy ssm_parameters with chart in ./secrets_parameters


SSM Encrypted Parameters a AWS Secrets should been created manually, not using Terraform, in order not to store plain text secrets on Git repos. **This repo is just for testing purpose.**
