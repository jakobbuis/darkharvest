# Sinatra endpoint for the AMT API callback
require 'json'
require 'sinatra'
require './config.rb'
require './database.rb'
require './models/contributor.rb'
require './models/repository.rb'

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
