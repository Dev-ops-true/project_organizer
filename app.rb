require_relative './lib/quotes'
require 'sinatra/base'
require 'sinatra/reloader'

class ProjectOrg < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    'Hello World'
  end

  get '/quotes' do
    @quotes = Quotes.all
    erb:'quotes/index'
  end

  run! if app_file == $0
end