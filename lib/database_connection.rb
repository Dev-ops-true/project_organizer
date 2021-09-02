require 'sqlite3'

class DatabaseConnection

  def self.setup(dbname)
    @connection = SQLite3::Database.new(dbname)
  end

  def self.connection
    @connection
  end

  def self.query(sql, params = [])
    @connection.execute(sql)
  end
end