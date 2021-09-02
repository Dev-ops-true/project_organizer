require 'sqlite3'

class Quotes

  attr_reader :id, :date_created, :client_id, :project_scope

  def initialize(id:, date_created:, client_id:, project_scope:)
    @id = id
    @date_created = date_created
    @client_id = client_id
    @project_scope = project_scope
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      @connection = SQLite3::Database.new "project_org_test.db"
    else  
      @connection = SQLite3::Database.new "project_org.db"  
    end
    result = @connection.execute("SELECT * FROM quotes;")
  end

  def self.create(date_created:, client_id:, project_scope:)
    if ENV['ENVIRONMENT'] == 'test'
      @connection = SQLite3::Database.new "project_org_test.db"
    else  
      @connection = SQLite3::Database.new "project_org.db"  
    end
    result = @connection.execute("INSERT INTO quotes (date_created, client_id, project_scope) VALUES ('#{date_created}', '#{client_id}', '#{project_scope}') RETURNING id, date_created, client_id, project_scope;")

    Quotes.new(id: result[0][0], date_created: result[0][1], client_id: result[0][2],project_scope: result[0][3])
  end

  def self.delete(id:) 
    if ENV['ENVIRONMENT'] == 'test'
      @connection = SQLite3::Database.new "project_org_test.db"
    else  
      @connection = SQLite3::Database.new "project_org.db"  
    end
    @connection.execute("DELETE FROM quotes WHERE id = '#{id}';")
  end

  def self.update(id:,date_created:, client_id:, project_scope:)
    if ENV['ENVIRONMENT'] == 'test'
      @connection = SQLite3::Database.new "project_org_test.db"
    else  
      @connection = SQLite3::Database.new "project_org.db"  
    end
    result = @connection.execute("UPDATE quotes SET date_created = '#{date_created}', client_id = '#{client_id}', project_scope = '#{project_scope}' WHERE id = '#{id}' RETURNING id, date_created, client_id, project_scope;")

    Quotes.new(id: result[0][0], date_created: result[0][1], client_id: result[0][2],project_scope: result[0][3])
  end

  def self.find(id:) 
    if ENV['ENVIRONMENT'] == 'test'
      @connection = SQLite3::Database.new "project_org_test.db"
    else  
      @connection = SQLite3::Database.new "project_org.db"  
    end
    result = @connection.execute("SELECT * FROM quotes WHERE id = '#{id}';")
    Quotes.new(id: result[0][0], date_created: result[0][1], client_id: result[0][2],project_scope: result[0][3])
  end

end