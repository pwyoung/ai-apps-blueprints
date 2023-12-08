
# Pull in the envrironment
locals {
  
  tags = {
    Terraform   = "true"
    Environment = "${var.environment}"
    Owner       = "${var.owner}"
  }

}


# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sagemaker_domain
# https://github.com/aws-samples/sagemaker-domain-vpconly-canvas-with-terraform/blob/main/sagemaker.tf
resource "aws_sagemaker_domain" "sagemaker_domain" {
  domain_name = var.domain_name
  auth_mode   = var.auth_mode
  vpc_id      = var.vpc_id
  subnet_ids  = var.subnet_ids

  default_user_settings {
    execution_role = aws_iam_role.sagemaker_iam_role.arn
  }

  tags = local.tags
}

################################################################################
# IAM
# TODO: use something like this
#   https://github.com/aws-samples/sagemaker-domain-vpconly-canvas-with-terraform/blob/main/submodules/iam/iam.tf
################################################################################
resource "aws_iam_role" "sagemaker_iam_role" {
  name               = "sagemaker_iam_role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.sagemaker_iam_policy_document.json
}


data "aws_iam_policy_document" "sagemaker_iam_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["sagemaker.amazonaws.com"]
    }
  }
}	