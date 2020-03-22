class LibraryRepository
  def all
  end
end

describe "LibraryRepository" do
  context 'get all libraries' do
    it 'should return one library' do
      # given
      repository = LibraryRepository.new
    
      # when
      result = repository.all
    
      # then
      expect(result.count).to eq(1)      
    end
  end
end