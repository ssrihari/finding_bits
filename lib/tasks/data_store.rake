DATASTORE_PATH_ENV_VARIABLE = "GH_CODESEARCH_DATASTORE_PATH"

namespace :datastore do
  desc "Retrieve all top repos for Ruby, Python, PHP and save to the datastore"
  task :retrieve_top_repos => :environment do
    datastore_path = ENV[DATASTORE_PATH_ENV_VARIABLE]
    languages = ["ruby", "python", "php"]

    puts "Datastore path: #{datastore_path}"
    languages.each { |language|
      language_data_store = GithubLanguageDatastore.new(datastore_path, language)
      puts "Retrieving top #{language} repos to #{language_data_store.top_repos_file}.."
      language_data_store.update_top_repos(">50")
    }
  end
end