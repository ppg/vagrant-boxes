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

## Known Issues

* [VeeWee does not work on Windows](https://github.com/jedi4ever/veewee/issues/6)
