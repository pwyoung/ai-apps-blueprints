# https://terragrunt.gruntwork.io/docs/features/keep-your-remote-state-configuration-dry/
#
# Example:
#   https://github.com/gruntwork-io/terragrunt-infrastructure-live-example/blob/4a8569c33088e13938d412f65a27a16d4e2d524b/terragrunt.hcl


# TG Locals
#   These are convenient aliases visible only within this file, per
#     https://terragrunt.gruntwork.io/docs/features/locals/#locals
locals {
  # This must be a globally unique name since it is used to name
  # the S3 bucket and DynamoDB table that manages Terraform state for this app.
  #
  # For convenience, this is "<tgstate>-<app_id>" where
  # app_id is set in ./app_metadata.hcl
  tg_app_id = "aiapps"

  # Environment variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  environment = local.environment_vars.locals.environment

  # Region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  #
  # Used in this file for the default AWS Provider
  aws_region = local.region_vars.locals.aws_region

  # Cloud-level variables
  cloud_vars = read_terragrunt_config(find_in_parent_folders("cloud.hcl"))

  # Account-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # compared in this file against 'allowed_account_ids'
  account_id = local.account_vars.locals.aws_account_id
}

# Create a default provider (in the terragrunt cache folder for the module executed)
#
# Generate an AWS provider block
generate "provider" {

  path      = "provider.tf"

  if_exists = "overwrite_terragrunt"

  contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"

  # Only these AWS Account IDs may be operated on by this template
  allowed_account_ids = ["${local.account_id}"]
}
EOF

}



# Create a backend.tf file (in the folder where the module is executed)
#
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "${local.tg_app_id}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
    dynamodb_table = "${local.tg_app_id}"
  }
  # Support running via 'TERRAGRUNT_DISABLE_INIT=true terragrunt run-all validate'
  # which will run without creating the remote backend
  # See: https://terragrunt.gruntwork.io/docs/reference/config-blocks-and-attributes/
  disable_init = tobool(get_env("TERRAGRUNT_DISABLE_INIT", "false"))
}


# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# `terragrunt.hcl` config via the include block.
# ---------------------------------------------------------------------------------------------------------------------

# Unused variables are pruned by TF
# That is visible in the debug output of 'terragrunt apply .tfplan --terragrunt-log-level debug --terragrunt-debug'
#
# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = merge(
  { app_id = local.tg_app_id },
  local.cloud_vars.locals,
  local.account_vars.locals,
  local.region_vars.locals,
  local.environment_vars.locals
)
