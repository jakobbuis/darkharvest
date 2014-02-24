# Gather all repositories for Eclipse
require 'httparty'
require 'config.rb'

#FIXME take the rate limit into account

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
    # and store them in the local database
    def execute!
        # Find the Eclipse foundation
        eclipse = self.class.get('https://api.github.com/orgs/eclipse')

        # Get all Eclipse repositories
        repositories = self.class.get(eclipse.repos_url)

        # Gather the basic information for each repository and store it in the database, once
        repositories.each do |repository|
            store_repository repository
        end

        # Gather the contributors of every repository
        Repository.all.each do |repository|
            # Note: normally, one would call the repository details page (e.g. api.github.com/repos/123)
            # to find the the contributors_url, but that takes an extra request against our rate limit
            # As this study is limited in scope (regarding time), we assume the GitHub API doesn't change
            contributors = self.class.get(repository.url+'/contributors')

            # Store every contributor in the database
            contributors.each do |contributor|
                store_contributor contributor
            end
        end

        # Grab all repositories of every contributor
        Contributors.all.each do |contributor|
            # Gather all repositories of this contributor
            repositories = self.class.get(contributor.repos_url)

            # Store every repository
            repositories.each do |repository|
                store_repository repository
            end
        end
    end

    private 

    def store_repository repository
        Repository.find_or_create_by(github_id: repository.id).update_attributes({
            github_id: repository.id,
            url: repository.url,
            name: repository.full_name,
            description: repository.description,
        }).save
    end

    def store_contributor contributor
        Contributor.find_or_create_by(github_id: contributor.id).update_attributes({
            github_id: contributor.id,
            url: contributor.url,
            name: contributor.full_name,
            description: contributor.description,
        }).save
    end
end

# Execute the main research process
GitHub.new(config.github.username, config.github.password).execute!
