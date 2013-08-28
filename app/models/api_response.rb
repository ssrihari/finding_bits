class ApiResponse < ActiveRecord::Base
  DATASTORE_PATH = ENV["GH_CODESEARCH_DATASTORE_PATH"]

  # Has the response been fulfilled and available for consumption?
  def available?
    status == 'available'
  end

  # Has the request been queued, but not fulfilled?
  def queued?
    status == 'queued'
  end

  def search_result
    @search_result ||= JSON.parse(response_json)
  end

  # Search and update the results.
  def search!
    raise "Cannot search on an unqueued request" unless queued?

    @search_result = GithubApi.new.code_search(search_snippet: search_snippet, repos: repos)
    update_attributes(response_json: @search_result.to_json)
  end

  # List of top repos for the given language
  def repos
    @repos ||= GithubLanguageDatastore.new(DATASTORE_PATH, language).retrieve_top_repos
  end

end