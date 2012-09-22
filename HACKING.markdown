# TODO: General
- Stack: Production is using the bamboo-ree-1.8.7 heroku stack.  Either migrate production to cedar, create a new production environment built from cedar, or create a staging environment with the old stack.  As of 9/1/2012, the staging branch can be deployed to a heroku cedar stack.
- Make repository public.  Need to permanently sanitize some information.
- PostgreSQL is required to setup a dev box, but you can get away with just sqlite3 (you just can't import production database as easily)

# TODO: Data Sanitization
1. Change main wwip Amazon API access keys, they were once located here:
   https://github.com/alexknowshtml/We-Work-In-Philly/blob/master/config/environments/development.rb
2. https://github.com/alexknowshtml/We-Work-In-Philly/blob/staging/config/twitter_auth.yml
3. https://github.com/alexknowshtml/We-Work-In-Philly/blob/master/config/settings.yml

# Build box setup
I needed to use do this gem on install on OSX 10.6
```
sudo env ARCHFLAGS="-arch x86_64" gem install pg
```

Check out this too, but it is newer than this repository
https://github.com/reidab/citizenry/blob/master/INSTALL.md

# Install Postgresql - I do not remember if I specified the 32-bit

## Install
```
brew install postgresql --32-bit
```

## Installation Notes
```
# Build Notes

If builds of PostgreSQL 9 are failing and you have version 8.x installed,
you may need to remove the previous version first. See:
  https://github.com/mxcl/homebrew/issues/issue/2510

To build plpython against a specific Python, set PYTHON prior to brewing:
  PYTHON=/usr/local/bin/python  brew install postgresqlSee:
  http://www.postgresql.org/docs/9.1/static/install-procedure.html

# Create/Upgrade a Database

If this is your first install, create a database with:
  initdb /usr/local/var/postgres

To migrate existing data from a previous major version (pre-9.1) of PostgreSQL, see:
  http://www.postgresql.org/docs/9.1/static/upgrading.html

# Start/Stop PostgreSQL

If this is your first install, automatically load on login with:
  mkdir -p ~/Library/LaunchAgents
  cp /usr/local/Cellar/postgresql/9.1.3/homebrew.mxcl.postgresql.plist ~/Library/LaunchAgents/
  launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist

If this is an upgrade and you already have the homebrew.mxcl.postgresql.plist loaded:
  launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
  cp /usr/local/Cellar/postgresql/9.1.3/homebrew.mxcl.postgresql.plist ~/Library/LaunchAgents/
  launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist

Or start manually with:
  pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start

And stop with:
  pg_ctl -D /usr/local/var/postgres stop -s -m fast
```

# Start Basic Server
```
# Step 1: Set your environment variables, then:
bundle exec ruby script/rails server
```

# Database Migrations go through bundle
```
# installs missing dependencies
bundle install

# migrate database
bundle exec rake db:migrate 

# prepare tests
bundle exec rake db:test:prepare
```

# rvm and ruby setup - THIS IS A REQUIREMENT
```
# I needed to add --with-gcc=clang for Snow Leopard and XCode 4.2 incompatibility
rvm install ruby-1.8.7-p370 --with-gcc=clang
```

# setting up local repository
```
git clone git@github.com:alexknowshtml/We-Work-In-Philly.git
git remote add production git@heroku.com:cold-fog-145.git
git remote add staging git@heroku.com:shrouded-retreat-7570.git

# IMPORTANT - prevents accidents
git config heroku.remote staging                                                                                                              
```

# development process
```
# switch to staging branch
git checkout staging

# push staging branch to origin remote.  Basically publish to github.
git push origin staging

# fix if somebody deployed to production remote, but never committed to main source tree
git fetch production
git merge production/master

# deploy to staging environment, branch is also called staging 
# -f is normal since this branch is used solely for transport
git push -f staging staging:master
```

# Database Hacking
```
# install addon for backups
heroku addons:add pgbackups:auto-month --app shrouded-retreat-7570

# backup production
heroku pgbackups:capture --app cold-fog-145

# restore the last snapshot of production to staging
heroku pgbackups:restore DATABASE `heroku pgbackups:url --app cold-fog-145` --app shrouded-retreat-7570

# connect to remote database! - make sure it's the right one!!!
heroku pg:psql --app shrouded-retreat-7570
```


# Local Development - Setup Postgresql
- Make sure database.yml is setup correctly
- Make sure database is running
```
# DANGEROUS - drop whatever is there
bundle exec rake db:drop db:create db:migrate db:test:prepare

# do a test via the terminal
echo "select * from companies" |  psql citizenry_dev

# import production data
curl -o latest.dump `heroku pgbackups:url --remote=production`
pg_restore --verbose --clean --no-acl --no-owner -d citizenry_dev latest.dump
```

# Local Development - Frequent Operation - Wipe Database
```
# clean database - DANGEROUS
bundle exec rake db:drop db:create db:migrate

# restart local server
bundle exec ruby script/rails server
```

# Restart heroku server
```
heroku pg:restart --app shrouded-retreat-7570
```

# Switch databases (needed if you upgrade from freemium databaase to store >10k records)
```
heroku pg:promote HEROKU_POSTGRESQL_IVORY
```
