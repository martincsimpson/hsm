class GitHubSource
  HTTP = GraphQL::Client::HTTP.new("https://api.github.com/graphql") do
    def headers(context)
      { "Authorization": "bearer #{ENV['github_token']}" }
    end
  end  

  Schema = GraphQL::Client.load_schema(HTTP)

  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
  
  RepositoryQuery = Client.parse <<-'GRAPHQL'
    query($queryString: String!) {
      search(first: 50, query: $queryString, type: REPOSITORY) {
        repositoryCount
        nodes {
          ... on Repository {
            name
            owner {
            	login
            }
            updatedAt
            description
            url
          }
        }
      }
    } 
  GRAPHQL
    
  def fetch language:
    raise "Language is required" if language.nil?
    
    query_string = "language:#{language} sort:updated_at"
    
    response = Client.query(RepositoryQuery, variables: { queryString: query_string})
        
    response.data.search.nodes.map do |github_repository|
      Library.from_github(github_repository)
    end
  end
end