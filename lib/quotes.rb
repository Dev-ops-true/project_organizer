require 'sqlite3'
require_relative 'database_connection'
require 'uri'
require_relative './labour'
require_relative './materials'

class Quotes

  attr_reader :id, :date_created, :client_id, :project_scope

  def initialize(id:, date_created:, client_id:, project_scope:)
    @id = id
    @date_created = date_created
    @client_id = client_id
    @project_scope = project_scope
  end

  def self.all 
    result = DatabaseConnection.query("SELECT * FROM quotes;")
    result.map do |quote| 
      Quotes.new(
        id: quote[0],
        date_created: quote[1],
        client_id: quote[2],
        project_scope: quote[3]
        )
    end    
  end

  def self.create(date_created:, client_id:, project_scope:)
    return false unless is_valid?(client_id) && is_valid?(project_scope)
    result = DatabaseConnection.query("INSERT INTO quotes (date_created, client_id, project_scope) 
              VALUES (
                '#{date_created}', 
                '#{client_id}', 
                '#{project_scope}'
                ) RETURNING id, date_created, client_id, project_scope;")
    Quotes.new(
      id: result[0][0], 
      date_created: result[0][1], 
      client_id: result[0][2],
      project_scope: result[0][3])
  end

  def self.delete(id:) 
    DatabaseConnection.query("DELETE FROM quotes WHERE id = '#{id}';")
  end

  def self.update(id:,date_created:, client_id:, project_scope:)
    result = DatabaseConnection.query("UPDATE quotes SET 
              date_created = '#{date_created}', 
              client_id = '#{client_id}', 
              project_scope = '#{project_scope}' 
              WHERE id = '#{id}' RETURNING id, date_created, client_id, project_scope;")
    Quotes.new(
      id: result[0][0], 
      date_created: result[0][1], 
      client_id: result[0][2], 
      project_scope: result[0][3])
  end

  def self.find(id:) 
    result = DatabaseConnection.query("SELECT * FROM quotes WHERE id = '#{id}';")
    Quotes.new(
      id: result[0][0], 
      date_created: result[0][1], 
      client_id: result[0][2], 
      project_scope: result[0][3])
  end

  def labour(labour_class = Labour)
    labour_class.all(quote_id: id)
  end

  def materials(materials_class = Materials)
    materials_class.all(quote_id: id)
  end

  private

  def self.is_valid?(quote_item)
    quote_item.length > 0
  end

end