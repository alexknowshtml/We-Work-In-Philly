source 'http://rubygems.org'

# Required since new heroku staging environment defaults to v1.9.2p290
ruby "1.8.7"

gem 'rails', '3.0.9'
gem 'rake', '0.9.2'

gem 'geocoder'

# You may need to add the following to your .bash_profile (or
# similar):
#
#     export DYLD_LIBRARY_PATH="/usr/local/mysql/lib:$DYLD_LIBRARY_PATH"
#
# gem 'mysql' 
gem 'pg'

gem 'aws-s3'

# gem 'hoptoad_notifier'

#--[ Utility ]------------------------------------------------------------------
gem 'httparty', '~> 0.7.4'
gem "json", "~> 1.4.6"
gem "json_builder"
gem 'addressable', '~> 2.2.4'
gem "friendly_id4", "4.0.0.beta3", :require => "friendly_id"

#--[ Authentication ]-----------------------------------------------------------
gem 'devise', "~> 1.1.5"
gem 'omniauth', "~> 0.2.6"

# Automatic login provider selection
gem 'redfinger', '~> 0.1.0', :git => "https://github.com/reidab/redfinger.git"
gem 'ruby-openid', '~> 2.1.8'
gem 'net-dns', '~> 0.6.1', :require => 'net/dns/resolver'

# Client libraries for authenticated services
gem 'twitter', '~> 1.6.0', :git => "https://github.com/apscott/twitter.git"
gem 'linkedin', '~> 0.2.2', :git => "https://github.com/pengwynn/linkedin.git", :tag => 'v0.2.2'
gem 'mogli', '~>0.0.25', :git => "https://github.com/reidab/mogli.git" # facebook
gem 'foursquare2', '~>1.1.0'   # https://gist.github.com/419219 <- github oauth docs!

#--[ Search ]-------------------------------------------------------------------
# If you're using the default sql-based search, you can comment this out.
# gem 'thinking-sphinx', '~> 2.0.1', :require => 'thinking_sphinx'

#--[ Model ]--------------------------------------------------------------------
gem "paperclip", "~> 2.3"
gem "inherited_resources", "~> 1.2.1"
gem "responders", "~> 0.6.2"

gem 'acts-as-taggable-on', "~> 2.0.6"

gem 'paper_trail', '~> 2'

# This was graybill's, but it broke build b/c of dependency on bundle-1.0.0.
# This was updated this to the origin of graybill's repository.

gem 'paper_trail_manager', :git => 'https://github.com/igal/paper_trail_manager.git'


#--[ View ]---------------------------------------------------------------------
gem "haml", "~> 3.1.2"
gem "sass", "~> 3.1.4"
gem "compass", "~> 0.10.5"
gem "compass-960-plugin", "~> 0.9.13", :require => 'ninesixty'
gem 'jquery-rails', '>= 0.2.6'
gem 'formtastic', '~>1.1.0'

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
  gem 'rcov'
  gem 'ruby-debug'
  gem 'annotate'
  gem "nifty-generators"
  gem 'powder'
  gem 'sqlite3-ruby', :require => 'sqlite3'
end


gem 'rspec-rails', '>= 2.0.0.beta.22'
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
