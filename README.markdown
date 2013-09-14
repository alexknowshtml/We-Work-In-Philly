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

## create database, migrate, prepare db tests
`bundle exec rake db:create db:migrate db:test:prepare`

## run the application
`./go`

NOTE: you must login as "sample user" when you run the application. we do not reveal the twitter/linkedin keys. if you're working on twitter/linkedin integration, you can provide your own keys in the go script. 


