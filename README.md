# Run the tests
github_token='<github_token>' rspec specs/*

# Run the web interface
github_token='<github_token>' ruby ui.rb
make a HTTP GET to /libraries/<language>

# Run the cli
github_token='<github_token>' ruby cli.rb <language>
