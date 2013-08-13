class SearchController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json {
        render :json => GithubCodeSearch.new(
            language: params[:language],
            search_snippet: params[:search_snippet]
        ).search
      }
    end
  end
end