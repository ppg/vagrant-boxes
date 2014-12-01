# SendGrid Vagrant Boxes

This repository uses [Packer](http://www.packer.io) to build base bases for
[Vagrant](http://www.vagrantup.com/).

[BENTO-21](https://tickets.opscode.com/browse/BENTO-21) is a good example of
why we don't just use the Opscode base boxes. Opscode gives conflicting advice
about whether their boxes are fit for public consumption, so it's safer (and
not that difficult) to just maintain our own.

We currently support the following platforms:

- Centos 7 + Chef 11
- Centos 6 + Chef 11
- Centos 6 + Chef 10 (Legacy)
- Ubuntu 10.04 + Chef 10 (Legacy)

Our boxes are currently hosted at: http://repo.sjc1.sendgrid.net/images/vagrant/

## How it Works

Packer reads its configuration from a `.json` file and uses Chef to provision the boxes.

## Getting Started

See [Workstation Setup](https://wiki.sendgrid.net/display/OPS/Workstation+Setup),
then clone the repository:

    git clone git@github.com:sendgrid-ops/vagrant-boxes.git
    cd vagrant-boxes

Install Packer:

    brew tap homebrew/binary
    brew install packer

## Building Boxes

In addition to the standard base boxes, we also maintain "devtools" boxes that include common development tools to speed up Chef runs. Use caution when using these boxes for testing cookbooks, as it may be difficult to know if your cookbook actually installed everything it needed, or if it's relying on something that happened to already be installed on the box.

You can see what Chef versions are available at https://www.getchef.com/download-chef-client/:

    # Install cookbooks
    berks vendor
    
    # Build legacy Chef 10 boxes
    packer build -var chef_version=10.32.2 ubuntu-10.04.json
    packer build -var chef_version=10.32.2 centos-6.json
    
    # Build Chef 11 boxes
    packer build centos-6.json
    packer build centos-7.json
    
    # Build "devtools" boxes
    packer build centos-6_devtools.json

If Packer fails, you can debug it by running the command again with the
`-debug` option or with `PACKER_LOG=1`. You might also want to try setting
`"headless": false` in the Packer template.

Once the boxes are built, import them into Vagrant:

    thor box:import [box]

You may want do some final testing by importing them into Vagrant and seeing if
they work:

    vagrant box list
    vagrant up [vm]
    vagrant ssh [vm]
    vagrant destroy

## Uploading Boxes

Before uploading a new box to the repository, remember to checksum it and
update the metadata appropriately:

    gsha1sum <box>
    open metadata/...
    thor box:upload [box]

## Known Issues

None!
