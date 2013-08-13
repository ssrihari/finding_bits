# Search Github for code snippets from the top repositories of a given language
class GithubCodeSearch
  def initialize(h)
    @language = h[:language]
    @search_snippet = h[:search_snippet]
    @datastore_path = ENV["GH_CODESEARCH_DATASTORE_PATH"]
  end

  def repos
    @repos ||= GithubLanguageDatastore.new(@datastore_path, @language).retrieve_top_repos
  end

  def search
    GithubApi.new.code_search(search_snippet: @search_snippet, repos: repos)
  end
end