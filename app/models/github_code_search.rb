# Search Github for code snippets from the top repositories of a given language
class GithubCodeSearch
  def initialize(h)
    @language = h[:language]
    @search_snippet = h[:search_snippet]
    @repos = GithubDatastore.new(ENV["GH_CODESEARCH_DATA_STORE_PATH"]).top_repos(language)
  end

  def search
    GithubApi.new.code_search(search_snippet: @search_snippet, repos: @repos)
  end
end