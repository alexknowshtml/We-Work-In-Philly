# Development Box Setup
We Work in Philly was forked from the citizenry project. It seems this project is no longer under active development. It is, however, useful for historical purposes.
- https://github.com/reidab/citizenry/

We Work in Philly is supported by all and owned by no one. Please see the GitHub issues log for some simple ways to contribute. There are several open items that might only require an hour or so of your time. If you have other ideas or enhancements, pull requests are always welcome.

# Development Box Setup

The setup assumes a nix based environment. If you are able to setup the build on a windows box, please document it here.  

## install PostgreSQL
- On a Mac: `brew install postgres`
- On Ubuntu / Debian: `sudo apt-get install postgresql libpq-dev`

## install rvm
`curl -L https://get.rvm.io | bash -s stable --rails --autolibs=enabled`

## setup ruby
`rvm install ruby-1.9.2`

## update gems
`gem update --system`

## install bundler
`gem install bundler`

## install dependencies
`env ARCHFLAGS="-arch x86_64" bundle install`

## install imagemagick
- On a Mac:
`brew install imagemagick`

- On Ubuntu / Debian:
`sudo apt-get install imagemagick`

## create database, migrate, prepare db tests
`bundle exec rake db:create db:migrate db:test:prepare`

## run the application
`./go`

NOTE: you must login as "sample user" when you run the application. we do not reveal the twitter/linkedin keys. if you're working on twitter/linkedin integration, you can provide your own keys in the go script. 

# Vagrant VM Setup

You can avoid installing the dependencies listed above on your machine by running the site in a self-contained virtual machine.

Before proceeding you need to have installed:

* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](http://www.vagrantup.com/)

To start up a vm:

* Clone this repo to your machine
* `cd We-Work-In-Philly` on your machine
* `vagrant up` on your machine
* Wait for the vm to load. The first time you run this command it will take a while as it installs a bunch of software. You'll know it's done when you see: `SETUP COMPLETE: We Work in Philly works in Vagrant!`
* `vagrant ssh` this will get you into the vm without a password
* `cd wwip` on the vm
* `./go` on the vm
* Open a browser on your machine: `http://192.168.33.10:3000`

Not familiar with Vagrant? Check out the [Getting Started](http://docs.vagrantup.com/v2/getting-started/index.html) guide.

`vagrant ssh` will get you onto the vm where you can run rake/rails commands, etc.

The code directory on your machine is mounted into the vm. When you ssh in it's in the `wwip` folder. You can edit files and perform git operations on your host computer using your tools of choice and the changes will be reflected on the vm.

After your first `vagrant up` you can [stop](http://docs.vagrantup.com/v2/getting-started/teardown.html) and [start](http://docs.vagrantup.com/v2/getting-started/up.html) the vm more quickly. The initial provisioning only needs to run once. If anything happens with your setup you can `vagrant destroy` and `vagrant up` to bring back a fresh environment.


## Original Developer Notes

Check out the [Original Developer Notes](https://github.com/alexknowshtml/We-Work-In-Philly/wiki/Developer-Notes).  There is a lot of useful recipes that explain how to setup development machines, switching from staging to production, migration of databases, etc.  It is not very organized though.
