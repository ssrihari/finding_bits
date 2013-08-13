DATASTORE_PATH_ENV_VARIABLE = "GH_CODESEARCH_DATASTORE_PATH"

namespace :datastore do
  desc "Retrieve all top repos for Ruby, Python, PHP and save to the datastore"
  task :retrieve_top_repos => :environment do
    datastore_path = ENV[DATASTORE_PATH_ENV_VARIABLE]
    languages = ["ruby", "python", "php"]

    puts "Datastore path: #{datastore_path}"
    languages.each { |language|
      puts "Updating #{language}.."; GithubLanguageDatastore.new(datastore_path, language).update_top_repos(">50")
    }
  end
end