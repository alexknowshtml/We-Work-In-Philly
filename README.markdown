# Development Box Setup
We Work in Philly was forked from the citizenry project.
- https://github.com/reidab/citizenry/
```
# Install Dependencies
env ARCHFLAGS="-arch x86_64" bundle install

# install rvm
curl -L https://get.rvm.io | bash

# setup ruby
rvm install ruby-1.8.7-p370

# create database, migrate, prepare db tests
bundle exec rake db:create db:migrate db:test:prepare

# start the server
bundle exec rails server
```
