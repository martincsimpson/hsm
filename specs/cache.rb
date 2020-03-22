require "graphql/client"
require "graphql/client/http"
require "rest-client"
require 'timecop'

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
    it 'should cache an object for only 5 seconds' do
      # given
      Cache.set_cache_ttl(5)
      cache_key = "abc"
      cache_string = "def"
    
      # when
      result = Cache.get_or_set(cache_key) { cache_string }
      
      Timecop.freeze(Time.now + 1)
      key_is_valid = Cache.key_is_valid?(cache_key)
      
      # then
      expect(key_is_valid).to eq(false)
    end
  end
end
