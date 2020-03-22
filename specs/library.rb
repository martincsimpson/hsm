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
      result = repository.all(language: "ruby")
    
      # then
      expect(result.first).to be_instance_of(Library)
    end
    
    it 'should return a library from github' do
      # given
      library = double("Library", source: :github)
      source = double("GitHubLibrarySource", name: :github, fetch: [library])      
      repository = Library::Repository.new(sources: [source])

      # when
      result = repository.all(language: "ruby")
    
      # then
      expect(result.first.source).to eq(:github)
    end

    it 'should return a library with a url' do
      # given
      library = double("Library", url: "https://www.google.com")
      source = double("GitHubLibrarySource", name: :github, fetch: [library])      
      repository = Library::Repository.new(sources: [source])

      # when
      result = repository.all(language: "ruby")
    
      # then
      expect(result.first.url).to eq("https://www.google.com")
    end
    
    it 'should return a library with a username' do
      # given
      library = double("Library", username: "martincsimpson")
      source = double("GitHubLibrarySource", name: :github, fetch: [library])      
      repository = Library::Repository.new(sources: [source])

      # when
      result = repository.all(language: "ruby")
    
      # then
      expect(result.first.username).to eq("martincsimpson")
    end
    
    it 'should return a library with a name' do
      # given
      library = double("Library", name: "library")
      source = double("GitHubLibrarySource", name: :github, fetch: [library])
      repository = Library::Repository.new(sources: [source])

      # when
      result = repository.all(language: "ruby")
    
      # then
      expect(result.first.name).to eq("library")
    end

    it 'should return a library with a description' do
      # given
      library = double("Library", description: "description")
      source = double("GitHubLibrarySource", name: :github, fetch: [library])
      repository = Library::Repository.new(sources: [source])

      # when
      result = repository.all(language: "ruby")
    
      # then
      expect(result.first.description).to eq("description")
    end

    it 'should return a library with a language' do
      # given
      library = double("Library", language: "ruby")
      source = double("GitHubLibrarySource", name: :github, fetch: [library])
      repository = Library::Repository.new(sources: [source])

      # when
      result = repository.all(language: "ruby")
    
      # then
      expect(result.first.language).to eq("ruby")
    end
    
  end
end
