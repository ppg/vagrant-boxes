# SendGrid Vagrant Boxes

This repository uses [Packer](http://www.packer.io) to build base bases for
[Vagrant](http://www.vagrantup.com/).

[BENTO-21](https://tickets.opscode.com/browse/BENTO-21) is a good example of
why we don't just use the Opscode base boxes. Opscode gives conflicting advice
about whether their boxes are fit for public consumption, so it's safer (and
not that difficult) to just maintain our own.

We currently support the following platforms:

- Centos 6 + Chef 11
- Centos 6 + Chef 10 (Legacy)
- Ubuntu 10.04 + Chef 10 (Legacy)

Our boxes are currently hosted at: http://repo.sjc1.sendgrid.net/images/vagrant/

We set the following VirtualBox options to prevent slow networking on CentOS 6
(See: [Vagrant 1172](https://github.com/mitchellh/vagrant/issues/1172)):

    --natdnsproxy1 off
    --natdnshostresolver1 off

## How it Works

Packer reads its configuration from `sendgrid.json` and uses Chef to provision
base boxes. As you'd expect, all provisioning cookbooks include their own
Test-Kitchen suites to allow local testing before releasing new base boxes.

## Getting Started

See [Workstation Setup](https://wiki.sendgrid.net/display/OPS/Workstation+Setup),
then clone the repository:

    git clone git@github.com:sendgrid-ops/vagrant-boxes.git
    cd vagrant-boxes

Install Packer:

    brew install packer

## Building Boxes

Before releasing new base boxes, please verify your changes (if any) by testing
them within the appropriate cookbook repo:

    cd cookbooks/vagrant_base_box
    kitchen converge [...]
    kitchen destroy [...]
    cd -

Remove old build artifacts:

    thor box:clean

Now we can build new boxes. Note that the `chef_version` variable is required
so that Packer knows which version of Chef to install. You can see what
versions are available at http://www.getchef.com/chef/install/:

    packer build -var chef_version=10.32.2 sendgrid.json # Legacy Chef 10 boxes
    packer build -var chef_version=11.12.4 -except=ubuntu-10.04 sendgrid.json

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

    thor box:upload [box]

## Updating Boxes

Once the new boxes are available, the next step is to update all the clients
that use them. Start by downloading all the cookbooks via the Thor task in
[chef-data](https://github.com/sendgrid-ops/chef-data):

    thor cookbooks:download
    thor cookbooks:exec 'git pull'

Now get the list of old base boxes:

    cd ~/projects/sendgrid
    grep -h 'box:' chef-*/.kitchen.yml | sort | uniq -c

For each old base box, update it to the new version (via the Thor task in
[chef-data](https://github.com/sendgrid-ops/chef-data)):

    thor cookbooks:box_update <old> <new>

Once all the base boxes are updated, commit and push your changes:

    thor cookbooks:exec "git commit .kitchen.yml -m 'Update base boxes'; git push; true"

## Known Issues

- Currently, integration tests are only run by Test-Kitchen. This means Packer
itself does not run any tests after building a box. We might want to fix this
someday.
