require 'database_helpers'

describe Quotes do
  
  before(:each) do
    @quote = Quotes.create(date_created:'01/09/2021', client_id:'3', project_scope:'Project scope 3')
    @quotes = Quotes.all
  end
   
  describe '.all' do
    it 'retrieves all quotes' do
      expect(@quotes.first).to include("01/09/2021", 3, "Project scope 3")
    end
  end

  describe '.create' do 
    it 'creates a new quote' do 
      persisted_data = persisted_data(id: @quote.id)
      expect(@quote).to be_a(Quotes)
      expect(@quote.id).to eq(persisted_data[0])
    end
  end

  describe '.delete' do
    it 'deletes the given quote' do
      Quotes.delete(id: @quote.id)
  
      expect(Quotes.all.length).to eq 0
    end
  end

end