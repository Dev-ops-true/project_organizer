describe Quotes do
  
  describe '.all' do
    it 'retrieves all quotes' do
      @connection = SQLite3::Database.new "project_org_test.db"

      @connection.execute("INSERT INTO quotes (date_created, client_id, project_scope, materials_table, labour_table, expenses_table) VALUES('01/09/2021', '3', 'Project scope 3', 'mt3', 'lt3', 'et3');")

      @quotes = Quotes.all

      expect(@quotes[0]).to include("01/09/2021", 3, "Project scope 3", "mt3", "lt3", "et3")
    end
  end

end