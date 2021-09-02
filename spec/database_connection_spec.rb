require 'database_connection'

describe DatabaseConnection do
  describe '.setup' do
    it 'sets up a connection to a database through SQLite3' do
      expect(SQLite3::Database).to receive(:new).with('project_org_test.db')

      DatabaseConnection.setup('project_org_test.db')
    end

    it 'this connection is persistent' do
      # Grab the connection as a return value from the .setup method
      connection = DatabaseConnection.setup('project_org_test.db')
    
      expect(DatabaseConnection.connection).to eq(connection)
    end
  end

  describe '.query' do
    it 'executes a query via SQLite' do
      connection = DatabaseConnection.setup('project_org_test.db')
      quote = Quotes.create(date_created:'01/09/2021', client_id:'3', project_scope:'Project scope 3')
      results = DatabaseConnection.query("SELECT * FROM quotes;")
      expect(connection).to receive(:execute).with("SELECT * FROM quotes;")
      DatabaseConnection.query("SELECT * FROM quotes;")
      p results
      p quote
    end
  end
end