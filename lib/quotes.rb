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

end