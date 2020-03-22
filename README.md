# Run the tests
github_token='9d6d7f1a32a5e1c5b74c8a7f7100318a5deabf2d' rspec specs/*

# Run the web interface
github_token='9d6d7f1a32a5e1c5b74c8a7f7100318a5deabf2d' ruby ui.rb
make a HTTP GET to /libraries/<language>

# Run the cli
github_token='9d6d7f1a32a5e1c5b74c8a7f7100318a5deabf2d' ruby cli.rb <language>