require "graphql/client"
require "graphql/client/http"
require "rest-client"

require './lib/cache'

describe "Cache" do
  context 'cache string' do
    it 'should cache a string' do
      # given
      cache_key = "abc"
      cache_string = "def"
    
      # when
      result = Cache.get_or_set(cache_key) { cache_string }
    
      # then
      expect(result).to eq("def")
    end
    it 'should cache a for only 5 seconds' do
      # given
      Cache.set_cache_ttl(2)
      cache_key = "abc"
      cache_string = "def"
    
      # when
      result = Cache.get_or_set(cache_key) { cache_string }
      sleep 5
      key_is_valid = Cache.key_is_valid?(cache_key)
      
      # then
      expect(key_is_valid).to eq(true)
    end
  end
end
