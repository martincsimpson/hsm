class LibraryRepository
  def all
    [Library.new]
  end
end

class Library
end

describe "LibraryRepository" do
  context 'get all libraries' do
    it 'should return a library' do
      # given
      repository = LibraryRepository.new
    
      # when
      result = repository.all
    
      # then
      expect(result.first).to be_instance_of(Library)
    end
  end
end