# factorio-headless-install
simple bash script to install factorio headless server as a service

# Prerequisites
1. aws account
2. ec2 instance running ubuntu 16.04

# This script intended for default AWS ec2 server running ubuntu 16.04 with default user [ubuntu]
# Install
1. on EC2 management console 
  - in the instances security group edit inbound rules
  - add a rule 
    - type: Custom UDP Rule
    - Protocol: UDP
    - Port Range: 34197
    - souce: anywhere
2. save Factorio.tar.xz to the instance
  - Create /home/ubuntu if not using default user [ubuntu]
  - Alternatively modify factorio.service with your home directory
3. extract Factorio.tar.xz
4. run setup.sh

This will finish by creating a save file and starting the server using default settings. 
To change settings go to .../factorio/data/ and edit the relevant .json files


# to do
 - create option to pass in version number as an argument.
