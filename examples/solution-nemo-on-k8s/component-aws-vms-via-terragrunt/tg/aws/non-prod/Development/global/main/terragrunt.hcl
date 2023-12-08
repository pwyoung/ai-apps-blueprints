
#   Use the "dependencies" block to force creation of
#   all the modules required to build the entire system.
dependencies {
  paths = [
    "../../us-east-2/pub/ec2",
    "../../us-east-2/prv/ec2",
    "../../us-west-2/vpc", # Redundant line, for documentation purposes
    "../../global/vpc-peering/us-east-2_us-west-2",
    "../../us-east-2/pub/nlb",
    "../../us-east-2/pub/nlb_attach_public_ec2_instances",
    "../../us-east-2/sagemaker",
  ]
}

# Include the top-level terragrunt.hcl file
# That will:
# - Manage the remote_state
# - Manage the default Provider(s)
# - Assign some inputs (e.g. account, region, environment)
include "root" {
  path = find_in_parent_folders()
}


# Include our module by dynamically create some terraform code here.
terraform {
  source = "${dirname(find_in_parent_folders())}//_modules/aws/main"
}
