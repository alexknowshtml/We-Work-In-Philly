namespace :deploy do
  desc "Deploy to staging"
  task :staging do
    sh "git push git@heroku.com:glowing-robot-700.git master"
    sh "heroku rake db:migrate --app glowing-robot-700"
    # sh "heroku restart --app growing-cloud-185"
    sh "open http://glowing-robot-700.heroku.com"
  end

  desc "Deploy to production"
  task :production do
    sh "git push git@heroku.com:cold-fog-145.git master"
    sh "heroku rake db:migrate --app cold-fog-145"
    # sh "heroku restart --app cold-fog-145"
    sh "open http://www.weworkinphilly.com"
  end
end