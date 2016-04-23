# The Bones project
*A bare bones MEAN stack*

* Use [packer](https://www.packer.io/) to provision a minimal CentOS-7 VM.
  * Store your application specific variables in a vars.json file as documented [here](https://www.packer.io/docs/templates/user-variables.html)
  * `export ATLAS_TOKEN=atlas token generated at atlas.hashicorp.com`
  * `cd packer`
  * `packer build -var-file=vars.json packer.json`
* Host your VM as a Vagrant box at [Atlas](https://atlas.hashicorp.com/).
* Host your VM as a AMI at [Amazon](https://console.aws.amazon.com/).
* Use [Vagrant](https://www.vagrantup.com/) to run a local development stack.
