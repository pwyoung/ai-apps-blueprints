# This supports SSH via proxy through the jump box

Example:
```
# Get the IPs of the public and private instances
make get-ec2-ips
ssh -F ./README.ssh-config.md jt hostname
```

# Config file

Put this in ~/.ssh/config and run
  ssh jt hostname

```
# Jump-box
Host jb
  HostName 54.81.236.32
  User ubuntu
  Port 22
  LogLevel FATAL
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  PasswordAuthentication no
  IdentitiesOnly yes
  IdentityFile /home/dev/.ssh/id_ed25519-devops
  # Forward my SSH keys into the session so I can SSH to another host
  # This is not needed with "ProxyCommand"
  # ForwardAgent yes

# Jump box target
Host jt
  HostName 10.0.1.53
  IdentityFile /home/dev/.ssh/id_ed25519-devops 
  IdentitiesOnly yes
  Port 22
  User ubuntu
  ProxyCommand ssh -q -W %h:%p jb
  LogLevel FATAL
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  PasswordAuthentication no
```