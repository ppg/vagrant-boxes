# SendGrid Vagrant Boxes

## Getting Started

Install prerequisites:

* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](http://vagrantup.com/)
* [Bundler](http://gembundler.com/)

Clone the repository and run Bundler:

    git clone git@github.com:sendgrid-ops/vagrant-boxes.git
    cd vagrant-boxes
    bundle install

## Building Boxes

    vagrant basebox list
    thor box:build [BOX]
    thor box:upload

## New Definitions

The definitions directory is inspired by Opscode's [Bento](https://github.com/opscode/bento)
project. Since the definitions are modularized, it should be sufficient in most
cases to copy an old definition and make the appropriate updates. For example:

    cp -R definitions/old definitions/new
    vi definitions/new/definition.rb # Change iso parameters

## Known Issues

* [VeeWee does not work on Windows](https://github.com/jedi4ever/veewee/issues/6)
