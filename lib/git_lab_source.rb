class GitLabSource
  def fetch language: nil
    raise "Language is required" if language.nil?
    
    query_params = {
      order_by: "updated_at",
      per_page: 50,
      with_programming_language: language
    }          
    
    raw_response = RestClient.get "https://gitlab.com/api/v4/projects", { params: query_params }
      
    JSON.parse(raw_response).map do |gitlab_repository|
      Library.from_gitlab(gitlab_repository)
    end
  end
end