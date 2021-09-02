require './lib/database_connection'

if ENV['ENVIRONMENT'] == 'test'
  DatabaseConnection.setup("project_org_test.db")
else
  DatabaseConnection.setup("project_org.db")
end