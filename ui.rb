require 'rubygems'
require 'sinatra'

require "graphql/client"
require "graphql/client/http"
require "rest-client"

require './lib/cache'
require './lib/library'
require './lib/git_hub_source'
require './lib/git_lab_source'

set :bind, '0.0.0.0'

get '/libraries/:language' do
  library_repository = Library::Repository.new(sources: [GitHubSource.new, GitLabSource.new])
  
  begin
    Cache.get_or_set(params[:language]) do
      JSON.dump(library_repository.all(language: params[:language]))
    end
  rescue Timeout::Error => e
    JSON.dump({ error: "TimeoutErrorFromBackend", message: "One or more of the resource backends have timed out"})
  end
end