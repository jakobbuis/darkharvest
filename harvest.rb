# Gather all repositories for Eclipse
require 'httparty'
require 'config.rb'

# Basic class for consuming the API
class GitHub
    include HTTParty
    base_uri 'https://api.github.com'
    basic_auth @username, @password

    def initialize(user, pass)
        @username = user
        @password = pass
    end

    # Gather all repositories from GitHub
    def execute!
        # Get all contributors
        # For each contributor
            # get all repositories
            # store in database
        # end
    end
end

# Execute the class
GitHub.new(config.github.username, config.github.password).execute!
