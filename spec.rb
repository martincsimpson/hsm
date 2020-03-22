require "graphql/client"
require "graphql/client/http"
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
end

class Library
  class Repository
  
    def initialize(source:)
      @source = source
    end
  
    def all
      @source.fetch
    end
  end
  
  attr_accessor :source, :url, :username, :name, :description, :language
end

describe "LibraryRepository" do
  context 'get all libraries' do
    it 'should return a library' do
      # given
      library = Library.new
      source = double("GitHubLibrarySource", name: :github, fetch: [library])
      
      repository = Library::Repository.new(source: source)
    
      # when
      result = repository.all
    
      # then
      expect(result.first).to be_instance_of(Library)
    end
    
    it 'should return a library from github' do
      # given
      library = double("Library", source: :github)
      source = double("GitHubLibrarySource", name: :github, fetch: [library])      
      repository = Library::Repository.new(source: source)

      # when
      result = repository.all
    
      # then
      expect(result.first.source).to eq(:github)
    end

    it 'should return a library with a url' do
      # given
      library = double("Library", url: "https://www.google.com")
      source = double("GitHubLibrarySource", name: :github, fetch: [library])      
      repository = Library::Repository.new(source: source)

      # when
      result = repository.all
    
      # then
      expect(result.first.url).to eq("https://www.google.com")
    end
    
    it 'should return a library with a username' do
      # given
      library = double("Library", username: "martincsimpson")
      source = double("GitHubLibrarySource", name: :github, fetch: [library])      
      repository = Library::Repository.new(source: source)

      # when
      result = repository.all
    
      # then
      expect(result.first.username).to eq("martincsimpson")
    end
    
    it 'should return a library with a name' do
      # given
      library = double("Library", name: "library")
      source = double("GitHubLibrarySource", name: :github, fetch: [library])
      repository = Library::Repository.new(source: source)

      # when
      result = repository.all
    
      # then
      expect(result.first.name).to eq("library")
    end

    it 'should return a library with a description' do
      # given
      library = double("Library", description: "description")
      source = double("GitHubLibrarySource", name: :github, fetch: [library])
      repository = Library::Repository.new(source: source)

      # when
      result = repository.all
    
      # then
      expect(result.first.description).to eq("description")
    end

    it 'should return a library with a language' do
      # given
      library = double("Library", language: "ruby")
      source = double("GitHubLibrarySource", name: :github, fetch: [library])
      repository = Library::Repository.new(source: source)

      # when
      result = repository.all
    
      # then
      expect(result.first.language).to eq("ruby")
    end
    
  end
end

describe "GitHubSource" do
  context 'get data' do
    it 'should get test data' do
      VCR.use_cassette("github_data") do
        HTTP = GraphQL::Client::HTTP.new("https://api.github.com/graphql") do
          def headers(context)
            # Optionally set any HTTP headers
            { "Authorization": "bearer 9d6d7f1a32a5e1c5b74c8a7f7100318a5deabf2d" }
          end
        end  

        Schema = GraphQL::Client.load_schema(HTTP)

        Client = GraphQL::Client.new(schema: Schema, execute: HTTP)

        RepositoryQuery = Client.parse <<-'GRAPHQL'
          query {
            viewer {
              name
              repositories(first: 50, privacy: PRIVATE, orderBy: { field:UPDATED_AT, direction:DESC}) {
                nodes {
                  url
                  name
                  updatedAt
                  owner {
                    login
                  }
                  description
                  languages(first: 1) {
                    edges {
                      node {
                        name
                      }
                    }
                  }
                }
              }
            }
          }
        GRAPHQL

        result = Client.query(RepositoryQuery)
      end
    end
  end
  
  context 'get all libraries' do
    it 'should fetch all libraries from github' do
      VCR.use_cassette("github_data") do
        # given
        # when
        # then
      end      
    end
  end
end