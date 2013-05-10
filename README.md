# SendGrid Vagrant Boxes

## Getting Started

See [Workstation Setup](https://wiki.sendgrid.net/display/OPS/Workstation+Setup),
then clone the repository and run bundler:

    git clone git@github.com:sendgrid-ops/vagrant-boxes.git
    cd vagrant-boxes
    bundle install

**Important note about Vagrant:** VeeWee is still dependent on the old Vagrant
gem for some reason. This means that in RVM environments, all Vagrant
commands must be prefixed with `rvm system do` in order to prevent RVM from
using the RubyGems install of Vagrant. Once you're done building base boxes,
it's probably a good idea to uninstall the Vagrant gem so that it doesn't
screw up other things in your environment.

    gem uninstal vagrant

## Building Boxes

    veewee vbox list
    thor box:build [name]

### Testing boxes

    vagrant list
    vagrant up <name>
    vagrant ssh <name>
    vagrant destroy <name>

### Uploading Boxes

    thor box:upload

## New Definitions

The definitions directory is inspired by Opscode's [Bento](https://github.com/opscode/bento)
project. Since the definitions are modularized, it should be sufficient in most
cases to copy an old definition and make the appropriate updates. For example:

    cp -R definitions/old definitions/new
    vi definitions/new/definition.rb # Change iso parameters

## Known Issues

* [VeeWee does not work on Windows](https://github.com/jedi4ever/veewee/issues/6)
