#!/bin/bash

set -e
#set -x

if [ ! -f /etc/vagrant_provisioned_at ]; then
  apt-get update
  apt-get -y install postgresql-9.1 libpq-dev imagemagick git-core ruby1.9.1-dev libxslt1-dev libxml2-dev

  curl -L https://get.rvm.io | bash -s stable --ruby=1.9.2 --autolibs=enabled
  source /usr/local/rvm/scripts/rvm
  gem install bundler linecache19

  su -l -c 'cd /home/vagrant/wwip && 
            env ARCHFLAGS="-arch x86_64" bundle install &&
            bundle exec rake db:create db:migrate db:test:prepare' vagrant

  date > /etc/vagrant_provisioned_at

  echo "SETUP COMPLETE: We Work in Philly works in Vagrant!"
  echo "Use 'vagrant ssh' to access the vm."
fi
