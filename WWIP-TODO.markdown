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
