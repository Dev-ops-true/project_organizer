require_relative './lib/quotes'
require 'sinatra/base'
require 'sinatra/reloader'
require './database_connection_setup'

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

  delete '/quotes/:id' do
    Quotes.delete(id: params[:id])
    redirect '/quotes'
  end

  get '/quotes/:id/edit' do
    @quote = Quotes.find(id: params[:id])
    erb:"/quotes/edit"
  end

  patch '/quotes/:id' do
    Quotes.update(id: params[:id],date_created: params[:date_created], client_id: params[:client_id], project_scope: params[:project_scope])
    redirect '/quotes'
  end
  

  run! if app_file == $0
end