class SearchController < ApplicationController
  def index
    respond_to do |format|
      format.html

      format.json {
        github_code_search = GithubCodeSearch.new(
            language: params[:language],
            search_snippet: params[:search_snippet]
        )

        # Is the response already available?
        if github_code_search.available?
          result = {"status" => "available", "result" => github_code_search.search_result}
        else
          # New search request. Queue it up.
          github_code_search.queue unless github_code_search.queued?
          result = {"status" => "queued"}
        end

        render :json => result
      }
    end
  end
end