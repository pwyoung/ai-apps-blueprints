########################################
# These are set by the top-level terragrunt.hcl.
# Most of these are set indirectly in files found
# in the path between the root and the module.
########################################

# Set by env.hcl
variable "environment" {
  type = string
}

# Set by region.hcl
variable "aws_region" {
  type = string
}

# Set by top-level/root ./terragrunt.hcl
variable "app_id" {
  type = string
}

########################################
# These are set in the low-level module,
########################################

variable "owner" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "domain_name" {
  type = string
}  

variable "auth_mode" {
  type = string
}  

variable "subnet_ids" {
  type = list
}  

#variable "execution_role" {
#  type = string
#}  




