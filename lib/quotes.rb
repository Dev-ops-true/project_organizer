require 'sqlite3'

class Quotes

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      @connection = SQLite3::Database.new "project_org_test.db"
    else  
      @connection = SQLite3::Database.new "project_org.db"  
    end
    result = @connection.execute("SELECT * FROM quotes;")
  end

  def self.create(date_created:, client_id:, project_scope:,
    materials_table:, labour_table:, expenses_table: )
    if ENV['ENVIRONMENT'] == 'test'
      @connection = SQLite3::Database.new "project_org_test.db"
    else  
      @connection = SQLite3::Database.new "project_org.db"  
    end
    @connection.execute("INSERT INTO quotes (date_created, client_id, project_scope, materials_table, labour_table, expenses_table) VALUES ('#{date_created}', '#{client_id}', '#{project_scope}', '#{materials_table}', '#{labour_table}', '#{expenses_table}');")
    
  end

end