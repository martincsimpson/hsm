# Setup
## Setup your access token
* Set your github_token (you can use a personal access token) in docker-compose.yml


# Run docker commands
## Start the web UI on port 4567
docker-compose up app

## Run the tests
docker-compose run app rspec specs/*

## Get CLI listening
docker-compose run app ruby cli.rb ruby
