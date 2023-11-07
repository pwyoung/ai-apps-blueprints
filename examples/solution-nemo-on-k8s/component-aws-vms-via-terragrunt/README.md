# GOAL

Demonstrate an example of how (and why) to use Terragrunt,
which is a thin layer on Terraform.

# Requirements

# Functionality

This creates two VPCs in AWS.

This demonstrates the advantage of Terragrunt for
automating VPC peering because all required configuration
(eg VPC IDs) are easily available via Terragrunt's
dependency/configuration mechanism.

Also, this demonstrates how Terragrunt supports building
any module (member of the dependency tree) if the disk structure
mirrors the resource dependency tree. For example, the VPCs can
be build in Terragrunt independently, and later the peering can
be added without requiring complex/error-prone config file hard-codes
or Terraform Data queries to get the required parameters.



