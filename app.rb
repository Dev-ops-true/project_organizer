require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require 'uri'
require 'date'
require_relative './lib/quotes'
require './database_connection_setup'


class ProjectOrg < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
  register Sinatra::Flash

  enable :sessions, :method_override
  
  get '/' do
    'Hello World'
  end

  get '/quotes' do
    @quotes = Quotes.all
    erb:'quotes/index'
  end

  get '/quotes/new' do
    @date = Date.today
    erb:"quotes/new"
  end

  post '/quotes/new/quote' do
    @new_quote = Quotes.create(date_created: params['date_created'], client_id: params['client_id'], project_scope: params['project_scope'])
    flash[:notice] = "Please fill in all fields" unless @new_quote
    @new_quote ? (redirect '/quotes') : (redirect '/quotes/new')
  end

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