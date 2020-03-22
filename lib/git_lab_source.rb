class GitLabSource
  def fetch language: nil
    raise "Language is required" if language.nil?
    
    query_params = {
      order_by: "updated_at",
      per_page: 50,
      with_programming_language: language
    }          
      
    # We need to use a .execute here, because we can't set the timeout using the standard RestClient.get method as per the documentation
    raw_response = RestClient::Request.execute(method: :get, url: "https://gitlab.com/api/v4/projects", headers: { params: query_params }, timeout: 30)
          
    JSON.parse(raw_response).map do |gitlab_repository|
      Library.from_gitlab(gitlab_repository)
    end
  end
end