
# Outputs from aws_sagemaker_domain
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sagemaker_domain#attribute-reference

output "home_efs_file_system_id" {
  description = "The ID of the Amazon Elastic File System (EFS) managed by this Domain."
  value       = resource.aws_sagemaker_domain.sagemaker_domain.home_efs_file_system_id
}

output "tags_all" {
  value       = resource.aws_sagemaker_domain.sagemaker_domain.tags_all
}



