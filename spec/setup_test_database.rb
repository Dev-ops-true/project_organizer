require 'sqlite3'

def setup_test_database
  p "Setting up test database..."
  @connection = SQLite3::Database.new "project_org_test.db"
  @connection.execute("DELETE FROM quotes")
end

