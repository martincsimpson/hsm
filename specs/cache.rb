require "graphql/client"
require "graphql/client/http"
require "rest-client"

require './lib/cache'

describe "Cache" do
  context 'cache string' do
    it 'should cache a string' do
      # given
      cache = Cache.new
      cache_key = "abc"
      cache_string = "def"
    
      # when
      result = Cache.get_or_set(cache_key) { cache_string }
    
      # then
      expect(result).to eq("hhh")
    end
    
  end
end
