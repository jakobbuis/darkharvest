# Sinatra endpoint for the AMT API callback
require 'json'
require 'sinatra'
require 'active_record'
require './models/contributor.rb'
require './models/repository.rb'

# Configure ActiveRecord
ActiveRecord::Base.establish_connection(ENV['HEROKU_POSTGRESQL_TEAL_URL'])
ActiveRecord::Base.include_root_in_json = false

# Show main interface
get '/' do
   erb :index
end

# Returns an unclassified entry
get '/next' do
    content_type :json
    Repository.unclassified.first.to_json only: [:id, :name, :description]
end

# Store the answer
post '/classify' do
    input = JSON.parse request.body.read.to_s
    Repository.find(input['id'].to_i).update_attribute('classification', input['classification'])
    'success'
end
