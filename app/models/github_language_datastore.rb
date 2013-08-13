class GithubLanguageDatastore

  attr_reader :language

  def initialize(root_path, language)
    @root_path = Pathname.new(root_path)
    @language = language
  end

  def retrieve_top_repos
    JSON.parse(top_repos_file.read)
  end

  def update_top_repos(stars)
    top_repos_file.open("w") { |f|
      f.write(GithubApi.new.top_repos(language: language, stars: stars).to_json)
    }
  end

  def top_repos_file
    @root_path.join("top_repos_#{language}.json")
  end
end