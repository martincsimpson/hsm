require 'rubygems'

require "graphql/client"
require "graphql/client/http"
require "rest-client"
require 'terminal-table'

require './lib/cache'
require './lib/library'
require './lib/git_hub_source'
require './lib/git_lab_source'

if ARGV.empty?
  puts "Language parameter is empty, correct syntax is:"
  puts "\t\truby cli.rb <language>"
  return
end

language = ARGV[0]

library_repository = Library::Repository.new(sources: [GitHubSource.new, GitLabSource.new])

## Not implementing caching here, but if we did we would have to use redis as the process is closed with every run
libraries = library_repository.all(language: language)

# Turn the rows into arrays for the table library to use
rows = libraries.map { |l| [l.source, l.url, l.username, l.name, (l.description || "")[0..20]] }

# Output the table
puts Terminal::Table.new :title => "Libraries", :headings =>['Source', 'URL', "Username", "Name", "Description"] , :rows => rows