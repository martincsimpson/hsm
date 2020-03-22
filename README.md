# Setup
## Setup your access token
* Set your github_token (you can use a personal access token) in docker-compose.yml
* You can get your token from here: https://github.com/settings/tokens

# Run docker commands
## Start the web UI (it will run on 127.0.0.1:4567)
docker-compose up app

## Run the tests
docker-compose run app rspec specs/*

## Get CLI listening
docker-compose run app ruby cli.rb ruby
