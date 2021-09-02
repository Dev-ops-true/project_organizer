require 'sqlite3'

def persisted_data(id:)
  @connection = SQLite3::Database.new "project_org_test.db"
  result = @connection.execute("SELECT * FROM quotes WHERE id = '#{id}';")
  result.first
end