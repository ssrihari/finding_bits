# Finding Bits

This is a wrapper interface on top of Github's code search interface that lets you search for specific code snippets from top repositories of different languages.

For example: <https://github.com/search?l=ruby&q=popen3&ref=cmdform&type=Code>

returns you search results for `popen3` from Ruby projects, but arranged in no useful order. I would rather see how `popen3` is used in popular repositories - for code reuse, and to understand best practices.

FindingBits does this by caching a list of the top projects in each language, and using the Github search API to search just those repositories.

# Installation

    git clone https://github.com/jasim/finding_bits.git
    cd finding_bits
    bundle
    rake db:setup
    
    # retrieve all the top repos into JSON files
    GH_CODESEARCH_DATASTORE_PATH=/tmp rake datastore:retrieve_top_repos

    GH_CODESEARCH_DATASTORE_PATH=/tmp rails server
    
