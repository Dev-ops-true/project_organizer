require 'database_helpers'

describe Quotes do
  
  before(:each) do
    @quote = Quotes.create(date_created:'01/09/2021', client_id:'3', project_scope:'Project scope 3')
    @quotes = Quotes.all
  end
   
  describe '.all' do
    it 'retrieves all quotes' do
      expect(@quotes.first.id).to eq(@quote.id)
    end
  end

  describe '.create' do 
    it 'creates a new quote' do 
      persisted_data = persisted_data(id: @quote.id)
      expect(@quote).to be_a(Quotes)
      expect(@quote.id).to eq(persisted_data[0])
    end

    it 'does not create a new quote if the fields are not filled in' do
      Quotes.delete(id: @quote.id)
      Quotes.create(date_created: "02/09/2021", client_id: "3", project_scope: "" )
      expect(Quotes.all).to be_empty
    end
  end

  describe '.delete' do
    it 'deletes the given quote' do
      Quotes.delete(id: @quote.id)
  
      expect(Quotes.all.length).to eq 0
    end
  end

  describe '.update' do
    it 'updates a quote' do
      persisted_data = persisted_data(id: @quote.id)
      quote = Quotes.update(id: persisted_data[0], date_created: "23/09/2021", client_id: "-2", project_scope: "Edited")
      expect(Quotes.all[0].id).to eq(quote.id)
    end
  end

  describe '.find' do
    it 'finds a requested quote' do
      result = Quotes.find(id: @quote.id)

      expect(result).to be_a(Quotes)
    end
  end

end