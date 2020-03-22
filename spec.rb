require "graphql/client"
require "graphql/client/http"
require "rest-client"

require './lib/library'
require './lib/git_hub_source'
require './lib/git_lab_source'

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
    
    it 'should contain the name paramter' do
      # given
      source = GitHubSource.new
      
      # when
      results = source.fetch(language: "ruby")
      
      # then
      expect(results.first.name).not_to be_empty
    end
    
    it 'should contain the url paramter' do
      # given
      source = GitHubSource.new
      
      # when
      results = source.fetch(language: "ruby")
      
      # then
      expect(results.first.url).not_to be_empty
    end
    
    it 'should contain the username paramter' do
      # given
      source = GitHubSource.new
      
      # when
      results = source.fetch(language: "ruby")
      
      # then
      expect(results.first.username).not_to be_empty
    end
    
    it 'should contain the description paramter' do
      # given
      source = GitHubSource.new
      
      # when
      results = source.fetch(language: "ruby")
      
      # then
      expect(results.first.description).not_to be_empty
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
    
    it 'should contain the name paramter' do
      # given
      source = GitLabSource.new
      
      # when
      results = source.fetch(language: "ruby")
      
      # then
      expect(results.first.name).not_to be_empty
    end
    
    it 'should contain the url paramter' do
      # given
      source = GitLabSource.new
      
      # when
      results = source.fetch(language: "ruby")
      
      # then
      expect(results.first.url).not_to be_empty
    end
    
    it 'should contain the username paramter' do
      # given
      source = GitLabSource.new
      
      # when
      results = source.fetch(language: "ruby")
      
      # then
      expect(results.first.username).not_to be_empty
    end
    
    it 'should contain the description paramter' do
      # given
      source = GitLabSource.new
      
      # when
      results = source.fetch(language: "ruby")
      
      # then
      expect(results.first.description).not_to be_empty
    end
    
  end  
end