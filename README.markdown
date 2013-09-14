# Development Box Setup
We Work in Philly was forked from the citizenry project. It seems this project is no longer under active development. It is, however, useful for historical purposes and there is a rails 3.2 branch that hints at how to upgrade.
- https://github.com/reidab/citizenry/

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
`brew install imagemagick`

## create database, migrate, prepare db tests
`bundle exec rake db:create db:migrate db:test:prepare`

## run the application
`./go`

NOTE: you must login as "sample user" when you run the application. we do not reveal the twitter/linkedin keys. if you're working on twitter/linkedin integration, you can provide your own keys in the go script. 

## Original Developer Notes

Check out the [Original Developer Notes](https://github.com/alexknowshtml/We-Work-In-Philly/wiki/Developer-Notes).  There is a lot of useful recipes that explain how to setup development machines, switching from staging to production, migration of databases, etc.  It is not very organized though.
