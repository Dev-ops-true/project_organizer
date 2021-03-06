require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require 'uri'
require 'date'
require_relative './lib/quotes'
require './database_connection_setup'
require_relative './lib/labour'
require_relative './lib/materials'
require_relative './lib/expenses'


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
    Labour.create(params, @new_quote.id)
    Materials.create(params, @new_quote.id)
    Expenses.create(params, @new_quote.id)
    flash[:notice] = "Please fill in all fields" unless @new_quote
    @new_quote ? (redirect '/quotes') : (redirect '/quotes/new')
  end

  delete '/quotes/:id' do
    Quotes.delete(id: params[:id])
    Labour.delete(params[:id])
    Materials.delete(params[:id])
    Expenses.delete(params[:id])
    redirect '/quotes'
  end

  get '/quotes/:id/edit' do
    @date = Date.today
    @quote = Quotes.find(id: params[:id])
    erb:"/quotes/edit"
  end

  patch '/quotes/:id' do
    Quotes.update(id: params[:id],date_created: params[:date_created], client_id: params[:client_id], project_scope: params[:project_scope])
    Labour.update(params, params[:id])
    Materials.update(params, params[:id])
    Expenses.update(params, params[:id])
    redirect '/quotes'
  end

  post '/labour/extra' do
    quote_id = params['current_quote_id']
    if params['labour_desc_0'] != ""
      Labour.create(params, quote_id)
    end
    if params['material_desc_0'] != ""
      Materials.create(params, quote_id)
    end
    if params['expense_desc_0'] != ""
      Expenses.create(params, quote_id)
    end
    redirect "/quotes/#{quote_id}/edit"
  end

  run! if app_file == $0
end