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