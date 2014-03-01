# Gather all repositories for Eclipse
require 'httparty'
require './config.rb'

# Basic class for consuming the API
class GitHub
    include HTTParty
    base_uri 'https://api.github.com'

    def initialize(user, pass)
        @config = {basic_auth: {username: user, password: pass}, headers: {'User-Agent' => 'jakobbuis/darkharvest'}}
    end

    # Gather all repositories from GitHub
    # and store them in the local database
    def execute!
        # Find the Eclipse foundation
        eclipse = self.class.get('https://api.github.com/orgs/eclipse', @config)

        # Grab each Eclipse repository and store it
        # repositories = self.class.get(eclipse.repos_url, @config).map! { |r| store_repository r } 

        # # Gather the contributors of every repository
        # repositories.each do |repository|
        #     # Note: normally, one would call the repository details page (e.g. api.github.com/repos/123)
        #     # to find the the contributors_url, but that takes an extra request against our rate limit
        #     # As this study is limited in scope (regarding time), we assume the GitHub API doesn't change
        #     contributors = self.class.get(repository.url+'/contributors', @config).map! { |c| store_contributor c } 
        # end

        # # Grab all repositories of every contributor
        # contributors.each do |contributor|
        #     # Store all repositories of this contributor
        #     repositories = self.class.get(contributor.repos_url, @config).map! { |r| store_repository r }
        # end
    end

    private 

    # Utility function that stores the relevant data of a repository automatically
    def store_repository repository
        Repository.find_or_create_by(github_id: repository.id).update_attributes({
            github_id: repository.id,
            url: repository.url,
            name: repository.full_name,
            description: repository.description,
        }).save
    end

    # Utility function that stores the relevant data of a contributor automatically
    def store_contributor contributor
        Contributor.find_or_create_by(github_id: contributor.id).update_attributes({
            github_id: contributor.id,
            url: contributor.url,
            name: contributor.full_name,
            description: contributor.description,
        }).save
    end

    # Override get method to take the rate limiter into account
    def self.get(*args, &block)
        result = super  # Execute the call to find the current rate limit
        raise 'Close to rate limit' if result.headers['x-ratelimit-remaining'].to_i < 100
        return result   # Return the original call
    end
end

# Execute the main research process
GitHub.new($config[:github][:user], $config[:github][:password]).execute!
