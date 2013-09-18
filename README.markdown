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

## Original Developer Notes

Check out the [Original Developer Notes](https://github.com/alexknowshtml/We-Work-In-Philly/wiki/Developer-Notes).  There is a lot of useful recipes that explain how to setup development machines, switching from staging to production, migration of databases, etc.  It is not very organized though.
