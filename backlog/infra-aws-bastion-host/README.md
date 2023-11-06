# TODO

Add a secured bastion host that meets the following:
- Can be used to perform all admin tasks
  - Runs AWS CLI and other tools we might need
- Supports network-level isolation
  - Resides in DMZ (to support network-level monitoring and isolation)
  - Can support VPN (e.g. OpenVPN) as/when needed
- Supports SSH
  - Secure SSH via MFA (Google PAM plugin)
  - Only stored authorized (public) SSH keys
- Avoids storing credentials
  - use SSH credential-forwarding as needed to avoid storing keys on the box
  - Grant priveleges as need to the host itself
- Is built from code
  - Build using code, not AWS Console work (e.g. via Packer and Terraform)
  - Can be deployed immediately (save AWS AMI)

# Resources
  https://medium.com/kaodim-engineering/hardening-ssh-using-aws-bastion-and-mfa-45d491288872
