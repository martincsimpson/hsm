require "graphql/client"
require "graphql/client/http"
require "rest-client"

require 'vcr'

VCR.configure do |c|
    c.cassette_library_dir = './fixtures/vcr_cassettes/'
    c.hook_into :webmock
end


require './lib/library'

require './lib/git_hub_source'

require './lib/git_lab_source'

describe "GitHubSource" do
  context 'get data' do
    it 'should get test data' do
      VCR.use_cassette('github_data') do
        # Given
        source = GitHubSource.new
      
        # When
        results = source.fetch(language: "ruby")
      
        # then
        expect(results.count).to eq(50)
      end
    end
    
    it 'should contain the name paramter' do
      VCR.use_cassette('github_data') do
        # given
        source = GitHubSource.new
      
        # when
        results = source.fetch(language: "ruby")
      
        # then
        expect(results.first.name).not_to be_empty
      end
    end
    
    it 'should contain the url paramter' do
      VCR.use_cassette('github_data') do
        # given
        source = GitHubSource.new
      
        # when
        results = source.fetch(language: "ruby")
      
        # then
        expect(results.first.url).not_to be_empty
      end
    end
    
    it 'should contain the username paramter' do
      VCR.use_cassette('github_data') do
        # given
        source = GitHubSource.new
      
        # when
        results = source.fetch(language: "ruby")
      
        # then
        expect(results.first.username).not_to be_empty
      end
    end
    
    it 'should contain the description paramter' do
      VCR.use_cassette('github_data') do
        # given
        source = GitHubSource.new
      
        # when
        results = source.fetch(language: "ruby")
      
        # then
        expect(results.first.description).not_to be_empty
      end
    end
    
  end  
end
