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
    library.username = response.owner.login
    library.description = response.description
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
