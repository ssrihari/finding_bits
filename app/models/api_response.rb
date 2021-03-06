class ApiResponse < ActiveRecord::Base
  DATASTORE_PATH = ENV["GH_CODESEARCH_DATASTORE_PATH"]
  RESPONSE_AVAILABLE = "available"
  RESPONSE_QUEUED = "queued"

  # Has the response been fulfilled and available for consumption?
  def available?
    status == RESPONSE_AVAILABLE
  end

  # Has the request been queued, but not fulfilled?
  def queued?
    status == RESPONSE_QUEUED
  end

  def search_result
    @search_result ||= JSON.parse(response_json)
  end

  # Search and update the results.
  def search!
    raise "Cannot search on an unqueued request" unless queued?

    @search_result = GithubApi.new.code_search(search_snippet: search_snippet, repos: repos)
    update_attributes(response_json: @search_result.to_json, status: ApiResponse::RESPONSE_AVAILABLE)
  end

  # This request has failed permanently. Remove itself so that it will be retried when someone tries again.
  def failed!
    destroy
  end

  # List of top repos for the given language
  def repos
    @repos ||= GithubLanguageDatastore.new(DATASTORE_PATH, language).retrieve_top_repos
  end

end