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

  get '/quotes/new' do
    erb:"quotes/new"
  end

  post '/quotes/new/quote' do
    Quotes.create(date_created: params['date_created'],
                  client_id: params['client_id'],
                  project_scope: params['project_scope'])
    redirect '/quotes'
  end

  enable :sessions, :method_override

  post '/quotes/:id' do
    Quotes.delete(id: params[:id])
    redirect '/quotes'
  end
  

  run! if app_file == $0
end