# Development Box Setup
We Work in Philly was forked from the citizenry project.
- https://github.com/reidab/citizenry/

# install rvm
`curl -L https://get.rvm.io | bash -s stable --rails --autolibs=enabled`

# setup ruby
`rvm install ruby-1.9.2`

# update gems
`gem update --system`

# install bundler
`gem install bundler`

# install dependencies
`env ARCHFLAGS="-arch x86_64" bundle install`

# create database, migrate, prepare db tests
`bundle exec rake db:create db:migrate db:test:prepare`

# start the server
`bundle exec rails server`


