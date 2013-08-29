# Provides github code search results and a queuing mechanism for requests.
# Wraps ApiResponse.
class GithubCodeSearch
  attr_reader :language, :search_snippet, :api_response_record

  delegate :status, :search_result, :queued?, :available?, :to => :api_response_record, :allow_nil => true

  def initialize(h)
    h = HashWithIndifferentAccess.new(h)
    @language = h[:language]
    @search_snippet = h[:search_snippet]
  end

  def api_response_record
    @api_response_record ||= ApiResponse.find_by(language: language, search_snippet: search_snippet)
  end

  # Create an ApiResponse entry and queue an async GithubApiRequest to update it with results of the query
  def queue
    @api_response_record = ApiResponse.create!(language: language, search_snippet: search_snippet, status: "queued")
    Delayed::Job.enqueue GithubCodeSearchJob.new(api_response_record.id)
  end
end