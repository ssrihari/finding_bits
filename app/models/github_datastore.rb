class GithubDatastore
  def initialize(root_path)
    @root_path = Pathname.new(root_path)
  end

  def top_repos(h)
    JSON.parse(@root_path.join("top_repos_#{h[:language]}.json").read)
  end
end