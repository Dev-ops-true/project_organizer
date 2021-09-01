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

  post '/quotes' do
    Quotes.create(date_created: params['date_created'],
                  client_id: params['client_id'],
                  project_scope: params['project_scope'],
                  materials_table: params['materials_table'],
                  labour_table: params['labour_table'],
                  expenses_table: params['expenses_table'])
    redirect '/quotes'
  end

  run! if app_file == $0
end