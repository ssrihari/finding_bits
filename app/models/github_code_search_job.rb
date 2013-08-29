class GithubCodeSearchJob < Struct.new(:api_response_record_id)
  def api_response
    @api_response ||= ApiResponse.find(api_response_record_id)
  end

  def perform
    api_response.search!
  end

  def failure(job)
    Delayed::Worker.logger.error "job_failed: #{api_response.attributes.to_json}"
    api_response.failed!
  end
end