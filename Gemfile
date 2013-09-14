source 'http://rubygems.org'

# Required since new heroku staging environment defaults to v1.9.2p290
ruby "1.9.2"

gem 'rails', '3.2.14'
gem 'rake', '0.9.2'

gem 'geocoder'

gem 'pg'

gem 'aws-sdk'

# gem 'hoptoad_notifier'

#--[ Utility ]------------------------------------------------------------------
gem 'httparty', '~> 0.8.0'
gem "json", "~> 1.6.1"
gem "addressable", "2.3.2", :require => 'addressable/uri'
gem "friendly_id4", "4.0.0.beta3", :require => "friendly_id"

#--[ Authentication ]-----------------------------------------------------------
gem 'devise', "~> 1.4.5"
gem "omniauth", "~> 1.1"


# Automatic login provider selection
gem 'redfinger'
gem 'ruby-openid', '~> 2.1.8'
gem 'net-dns', '~> 0.6.1', :require => 'net/dns/resolver'

# Client libraries for authenticated services
gem "omniauth-twitter"
gem "omniauth-linkedin"
gem "omniauth-facebook"
gem "omniauth-foursquare"
gem "omniauth-github"
gem 'omniauth-google-apps'
gem 'omniauth-openid'

#--[ Search ]-------------------------------------------------------------------
# If you're using the default sql-based search, you can comment this out.
# gem 'thinking-sphinx', '~> 2.0.1', :require => 'thinking_sphinx'

#--[ Model ]--------------------------------------------------------------------
gem "paperclip", "~> 2.3"
gem "inherited_resources", "~> 1.3.1"
gem "responders", "~> 0.6.2"

gem 'acts-as-taggable-on', "~> 2.1.1"

gem 'paper_trail', '~> 2'

# This was graybill's, but it broke build b/c of dependency on bundle-1.0.0.
# This was updated this to the origin of graybill's repository.

gem 'paper_trail_manager', :git => 'https://github.com/igal/paper_trail_manager.git'


#--[ View ]---------------------------------------------------------------------
gem "haml", "~> 3.1.2"
gem "sass", "~> 3.1.4"
gem "compass-960-plugin", "~> 0.10.4", :require => "ninesixty"
gem "jquery-rails", ">= 1.0.14"
gem "formtastic", "2.2.1"

#--[ Controller ]---------------------------------------------------------------
gem 'will_paginate', '~> 3.0.beta'

#--[ Middleware ]---------------------------------------------------------------
gem 'rack-jsonp', '~> 1.2.0'


# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  # -- [ IRB ] -----------------------------------------------------------------
  gem 'awesome_print'
  gem 'drx'
  gem 'wirble'
  gem 'utility_belt'

  # -- [ Tools ] ---------------------------------------------------------------
  gem 'heroku'
  gem "simplecov"
  gem 'ruby-debug19'
  gem 'annotate'
  gem "nifty-generators"
  gem 'powder'
  gem 'sqlite3-ruby', :require => 'sqlite3'
end


gem "rspec-rails", ">= 2.6.0"
group :test do
  # -- [ Testing ] -------------------------------------------------------------
  gem "mocha"
  gem "fakeweb"
  gem "factory_girl_rails"
  gem 'faker'
  gem 'uuid'
  gem 'steak', '1.1.0'
  gem 'capybara', '~> 0.4.0'
  # gem 'capybara-envjs'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'faker'
  gem 'spork'
end
