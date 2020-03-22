class Library
  class Repository
  
    # We need a list of sources so we can easily extend this in the future (dependency injection)
    def initialize(sources:)
      @sources = sources
    end
  
    # Make a call to the sources with the language param and concatenate and flatten them
    def all language:
      return "Language Is Required" if language.nil?
      @sources.map { |s| s.fetch(language: language) }.flatten
    end
  end
end

class Library
  attr_accessor :source, :url, :username, :name, :description

  # Generate a json string, so that it can be rendered by sinatra
  def to_json(options)
    JSON.dump({
      source: source,
      url: url,
      username: username,
      name: name,
      description: description
    })
  end
  
  # Parse the response from github into a library object using the Factory pattern
  def self.from_github(response)
    library = Library.new
    library.source = :github
    library.name = response.name
    library.url = response.url
    library.username = response.owner.login
    library.description = response.description
    library
  end
  
  # Parse the response from gitlab into a library object using the Factory pattern
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
