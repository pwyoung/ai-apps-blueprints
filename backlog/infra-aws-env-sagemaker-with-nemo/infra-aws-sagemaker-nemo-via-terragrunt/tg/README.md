# Goal

This will:
- create two VPCs
- peer them
- add public and private EC2 instances
- add a Network-Load-Balancer to one VPC and attach the public instances in that VPC to it

# Conventions in this code

## Terragrunt Dependencies

This code takes advantage of Terragrunt Dependencies.
https://terragrunt.gruntwork.io/docs/reference/config-blocks-and-attributes/#dependency

TG deps support running "plan" and "apply" in isolated directories while:
- defining the modules that must be run first
- making it easy to access the output/parameters from those modules

## Disk Structure

This project is laid out on disk so that we can easily see the
"physical" structure reflected in the deployment.

Individual environments are separated.
This supports development of this code as well as customizing/scaling the various
environments (e.g. dev doesn't need all the ec2 instances prod might need).

Environment:
   ./<cloud>/<deployment>/<environment>
   e.g. ./aws/non-prod/Development

The layout within each Environment is generally like this:
  ./<region>/<scope>/COMPONENT/
  e.g. ./us-east-2/pub/ec2/terragrunt.hcl

Some resources in a cloud account are outside any region.
Those resources are put inside a pseudo-region called "global".
e.g.:
  ./aws/non-prod/Development/global

## Starting place

All modules in an environment can be built by building
the ./global/main module. Location:
  ./<cloud>/<deployment>/<environment>/global/main

e.g.:
  ./aws/non-prod/Development/global/main
