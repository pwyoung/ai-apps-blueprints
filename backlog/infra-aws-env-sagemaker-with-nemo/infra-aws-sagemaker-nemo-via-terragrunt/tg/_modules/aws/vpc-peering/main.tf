provider "aws" {
  alias      = "this"
  region     = var.this_vpc_region
}

provider "aws" {
  alias      = "peer"
  region     = var.peer_vpc_region
}

module "single_account_multi_region" {
  source = "github.com/grem11n/terraform-aws-vpc-peering"
  
  providers = {
    aws.this = aws.this
    aws.peer = aws.peer
  }

  this_vpc_id = var.this_vpc_id
  peer_vpc_id = var.peer_vpc_id

  auto_accept_peering = true

  tags = {
    Name        = "tf-single-account-multi-region"
    Environment = "Test"
  }
}