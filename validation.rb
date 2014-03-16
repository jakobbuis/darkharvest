# Sinatra endpoint for the AMT API callback
require 'json'
require 'sinatra'
require './database'
require './models/repository.rb'

# Show main interface
get '/classified/:count' do |count|
    @repositories = Repository.known.random(count)
    erb :index
end

get '/unknown' do
    @repositories = Repository.unknown
    erb :index
end
