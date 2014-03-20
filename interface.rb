# Sinatra endpoint for the AMT API callback
require 'json'
require 'sinatra'
require './database'
require './models/repository.rb'
require './models/contributor.rb'

# Show main interface
get '/classified/:count' do |count|
    @repositories = Repository.known.not_duplicate.random(count)
    erb :validation
end

get '/unknown' do
    @repositories = Repository.unknown
    erb :validation
end

get '/results' do
    @contributors = Contributor.multihomers
    erb :results
end
