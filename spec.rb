class Library
end

describe "LibraryRepository" do
  context 'get all libraries' do
    
    it 'should return a library' do
      # given
      class LibraryRepository
        def all
          [Library.new]
        end
      end
      
      repository = LibraryRepository.new
    
      # when
      result = repository.all
    
      # then
      expect(result.first).to be_instance_of(Library)
    end
    
    it 'should return a library from github' do
      # given
      source = double("GitHubLibrarySource", name: :github, fetch: [Library.new])
      
      class LibraryRepository
        def initialize source:
          @source = source
        end
        
        def all
          @source.fetch
        end
      end
      
      repository = LibraryRepository.new(source: source)

      # when
      result = repository.all
    
      # then
      expect(result.first.source).to eq(:github)
    end
    
  end
end