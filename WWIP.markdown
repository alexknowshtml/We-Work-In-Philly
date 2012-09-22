# TODO: General
1. Making sure all staging -> production issues worked out.  Production is using the bamboo-ree-1.8.7 heroku stack.  Either migrate production to cedar, create a new production environment built from cedar, or create a staging environment with the old stack.  As of 9/1/2012, the staging branch can be deployed to a heroku cedar stack.
2. Make repository public.  Need to permanently sanitize some information.
3. Figure out why top navigation screwed up on the staging site (some kind of CSS issue)
4. Widget updated with new aesthetic
5. Categories implemented
6. Maps should be setup correctly as a resource with appropriate routes
7. Mapfeed is generated manually via json, should just be using Company.as_json method (probably)

# TODO: Data Sanitization
1. https://github.com/alexknowshtml/We-Work-In-Philly/blob/master/config/environments/development.rb
2. https://github.com/alexknowshtml/We-Work-In-Philly/blob/master/config/twitter_auth.yml
3. https://github.com/alexknowshtml/We-Work-In-Philly/blob/master/config/settings.yml

# Development Box Setup
Check out this too, but it is newer than the version of citizenry we forked from:
- https://github.com/reidab/citizenry/blob/master/INSTALL.md

PostgreSQL installation and upgrade procedures:
- http://www.postgresql.org/docs/9.1/static/install-procedure.html
- http://www.postgresql.org/docs/9.1/static/upgrading.html

```
# I needed to use do this gem on install on OSX 10.6
sudo env ARCHFLAGS="-arch x86_64" gem install pg

# Install Postgresql - I do not remember if I specified the 32-bit
brew install postgresql --32-bit

# Start PostgreSQL (see below for instructions).  PostgreSQL is not required to setup a dev box, but then cannot import production database as easily

# Create database
initdb /usr/local/var/postgres

# migrate database
bundle exec rake db:migrate 

# create database, migrate, and prepare db tests
bundle exec rake db:create db:migrate db:test:prepare

# rvm and ruby setup, I needed --with-gcc=clang for Snow Leopard and XCode 4.2 incompatibility
rvm install ruby-1.8.7-p370 --with-gcc=clang

# clone git repository, set remotes, staging is cera's staging server
git clone git@github.com:alexknowshtml/We-Work-In-Philly.git
cd We-Work-In-Philly
git remote add production git@heroku.com:cold-fog-145.git
git remote add staging git@heroku.com:shrouded-retreat-7570.git

# switch to staging branch
git checkout staging

# IMPORTANT - prevents accidents
git config heroku.remote staging                                                                                                              

# installs missing dependencies
bundle install
```

# Routine Database Maintenance

## Install, Start, and Stop PostgreSQL

If this is your first install, automatically load on login with:

```
  mkdir -p ~/Library/LaunchAgents
  cp /usr/local/Cellar/postgresql/9.1.3/homebrew.mxcl.postgresql.plist ~/Library/LaunchAgents/
  launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
```

If this is an upgrade and you already have the homebrew.mxcl.postgresql.plist loaded:

```
  launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
  cp /usr/local/Cellar/postgresql/9.1.3/homebrew.mxcl.postgresql.plist ~/Library/LaunchAgents/
  launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
```

Or start manually with:

```
  pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
```

And stop with:

```
  pg_ctl -D /usr/local/var/postgres stop -s -m fast
```





# Local Development 

## Commands and Maintenance
```
# setup environment variables
. cera-dev/dev.sh

# DANGEROUS - clean database
bundle exec rake db:drop db:create db:migrate
bundle exec rake db:drop db:create db:migrate db:test:prepare

# test that database is accessible
echo "select * from companies" |  psql citizenry_dev

# Make sure configuration files setup correctly
cat config/database.yml
cat config/settings.yml

# start rails
bundle exec ruby script/rails server

# import production to local database
curl -o latest.dump `heroku pgbackups:url --remote=production`
pg_restore --verbose --clean --no-acl --no-owner -d citizenry_dev latest.dump
```


## Git - Publishing and Receiving changes
```
# push staging branch to origin remote.  Basically publish to github.
git push origin staging

# fix if somebody deployed to production remote, but never committed to main source tree
git fetch production
git merge production/master

# deploy to staging environment, branch is also called staging 
# -f is normal since this branch is used solely for transport
git push -f staging staging:master
```



# Heroku Development

## Commands and Maintenance
```
# Restart heroku server
heroku pg:restart --app shrouded-retreat-7570

# Switch databases (needed if you upgrade from freemium databaase to store >10k records)
heroku pg:promote HEROKU_POSTGRESQL_IVORY
```

# Database Maintenance
```
# install addon for backups
heroku addons:add pgbackups:auto-month --app shrouded-retreat-7570

# backup production db
heroku pgbackups:capture --app cold-fog-145

# connect to remote database to make sure it's the right one
heroku pg:psql --app shrouded-retreat-7570

# restore the last snapshot of production to staging
heroku pgbackups:restore DATABASE `heroku pgbackups:url --app cold-fog-145` --app shrouded-retreat-7570
```
