require "graphql/client"
require "graphql/client/http"
require "rest-client"

class Library
  class Repository
  
    def initialize(sources:)
      @sources = sources
    end
  
    def all
      @sources.map { |s| s.fetch }.flatten
    end
  end
  
  attr_accessor :source, :url, :username, :name, :description
  
  def self.from_github(response)
    library = Library.new
    library.source = :github
    library.name = response.name
    library.url = response.url
    library
  end
  
  def self.from_gitlab(response)
    library = Library.new
    library.source = :gitlab
    library.name = response['name']
    library.url = response['web_url']
    library.username = response['namespace']['full_path']
    library.description = response['description']
    library
  end
end

class GitHubSource
  HTTP = GraphQL::Client::HTTP.new("https://api.github.com/graphql") do
    def headers(context)
      { "Authorization": "bearer 9d6d7f1a32a5e1c5b74c8a7f7100318a5deabf2d" }
    end
  end  

  Schema = GraphQL::Client.load_schema(HTTP)

  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
  
  RepositoryQuery = Client.parse <<-'GRAPHQL'
    query($queryString: String!) {
      search(first: 50, query: $queryString, type: REPOSITORY) {
        repositoryCount
        nodes {
          ... on Repository {
            name
            owner {
            	login
            }
            updatedAt
            description
            url
          }
        }
      }
    } 
  GRAPHQL
    
  def fetch language:
    raise "Language is required" if language.nil?
    
    query_string = "language:#{language} sort:updated_at"

    response = Client.query(RepositoryQuery, variables: { queryString: query_string})
        
    response.data.search.nodes.map do |github_repository|
      Library.from_github(github_repository)
    end
  end
end

class GitLabSource
  def fetch language: nil
    raise "Language is required" if language.nil?
    
    query_params = {
      order_by: "updated_at",
      per_page: 50,
      with_programming_language: language
    }          
    
    raw_response = RestClient.get "https://gitlab.com/api/v4/projects", { params: query_params }
      
    JSON.parse(raw_response).map do |gitlab_repository|
      Library.from_gitlab(gitlab_repository)
    end
  end
end


describe "LibraryRepository" do
  context 'get all libraries' do
    it 'should return a library' do
      # given
      library = Library.new
      source = double("GitHubLibrarySource", name: :github, fetch: [library])
      
      repository = Library::Repository.new(sources: [source])
    
      # when
      result = repository.all
    
      # then
      expect(result.first).to be_instance_of(Library)
    end
    
    it 'should return a library from github' do
      # given
      library = double("Library", source: :github)
      source = double("GitHubLibrarySource", name: :github, fetch: [library])      
      repository = Library::Repository.new(sources: [source])

      # when
      result = repository.all
    
      # then
      expect(result.first.source).to eq(:github)
    end

    it 'should return a library with a url' do
      # given
      library = double("Library", url: "https://www.google.com")
      source = double("GitHubLibrarySource", name: :github, fetch: [library])      
      repository = Library::Repository.new(sources: [source])

      # when
      result = repository.all
    
      # then
      expect(result.first.url).to eq("https://www.google.com")
    end
    
    it 'should return a library with a username' do
      # given
      library = double("Library", username: "martincsimpson")
      source = double("GitHubLibrarySource", name: :github, fetch: [library])      
      repository = Library::Repository.new(sources: [source])

      # when
      result = repository.all
    
      # then
      expect(result.first.username).to eq("martincsimpson")
    end
    
    it 'should return a library with a name' do
      # given
      library = double("Library", name: "library")
      source = double("GitHubLibrarySource", name: :github, fetch: [library])
      repository = Library::Repository.new(sources: [source])

      # when
      result = repository.all
    
      # then
      expect(result.first.name).to eq("library")
    end

    it 'should return a library with a description' do
      # given
      library = double("Library", description: "description")
      source = double("GitHubLibrarySource", name: :github, fetch: [library])
      repository = Library::Repository.new(sources: [source])

      # when
      result = repository.all
    
      # then
      expect(result.first.description).to eq("description")
    end

    it 'should return a library with a language' do
      # given
      library = double("Library", language: "ruby")
      source = double("GitHubLibrarySource", name: :github, fetch: [library])
      repository = Library::Repository.new(sources: [source])

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
      # Given
      source = GitHubSource.new
      
      # When
      results = source.fetch(language: "ruby")
      
      # then
      expect(results.count).to eq(50)
    end
  end  
end

describe "GitLabSource" do
  context 'get data' do
    it 'should get test data' do      
      # Given
      source = GitLabSource.new
      
      # When
      results = source.fetch(language: "ruby")
      
      # then
      expect(results.count).to eq(50)
    end
  end  
end