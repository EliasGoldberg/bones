The bones project creates a barebones MEAN stack.

It uses packer to provision a Vagrant box and Amazon AMI.

An atlas account can be made here: https://atlas.hashicorp.com/
Atlas is where you host your vagrant box.

Packer can be downloaded here: https://www.packer.io/

to build a minimal vagrant box
  export ATLAS_TOKEN=<atlas token generated at atlas.hashicorp.com>
  cd packer
  packer build -var-file=vars.json packer.json
