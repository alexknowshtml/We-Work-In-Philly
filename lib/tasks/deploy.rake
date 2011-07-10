namespace :deploy do
  desc "Deploy to staging"
  task :staging do
    sh "git push git@heroku.com:growing-cloud-185.git master"
    sh "heroku rake db:migrate --app growing-cloud-185"
    # sh "heroku restart --app growing-cloud-185"
    sh "open http://growing-cloud-185.heroku.com"
  end

  desc "Deploy to production"
  task :production do
    sh "git push git@heroku.com:cold-fog-145.git master"
    sh "heroku rake db:migrate --app cold-fog-145"
    # sh "heroku restart --app cold-fog-145"
    sh "open http://www.weworkinphilly.com"
  end
end