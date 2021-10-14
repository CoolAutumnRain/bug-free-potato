# bug-free-potato

## What does it do?
Builds IaaC for a small company moving infrastructure to the cloud.

note that ssh keys are not provided - we're using a previously uploaded public key referenced by name. 


One can only SSH into the tf-ansible server from the outside and from there on use ansible to configure the services - and after that is done one should open ports on tf-ansible to allow VPN traffic and use it as a VPN tunnel to the intranet. 

This also means if one is attempting to SSH into the webserver or the jitsiserver one has to go via the tf-ansible as well - these servers on the DMZ only allow ssh from the specific IP of the tf-ansible. 
