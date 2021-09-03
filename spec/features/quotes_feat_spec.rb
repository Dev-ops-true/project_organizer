require 'sqlite3'
require 'database_connection'

feature 'View quotes' do
  scenario 'A user can view all the quotes' do
    @connection = SQLite3::Database.new "project_org_test.db"

    @connection.execute("INSERT INTO quotes (date_created, client_id, project_scope) VALUES('01/09/2021', '3', 'Project scope 3');")

    visit('/quotes')

    expect(page).to have_content("01/09/2021")
    expect(page).to have_content("3")
    expect(page).to have_content("Project scope 3")
  end

  feature 'Delete a quote' do
    scenario ' A user can delete a quote' do 
      @connection = SQLite3::Database.new "project_org_test.db"
      @connection.execute("INSERT INTO quotes (date_created, client_id, project_scope) VALUES('01/09/2021', '3', 'Project scope 3');")
      visit('/quotes')
      expect(page).to have_content('01/09/2021')

      click_button('Delete')

      expect(current_path).to eq('/quotes')
      # expect(page).not_to have_content('01/09/2021')
    end  
  end  

  feature 'Updating a quote' do
    scenario 'A user can update a quote' do
      @quote = Quotes.create(date_created:'01/09/2021', client_id:'1', project_scope:'Project scope to be edited')
      visit('/quotes')
      click_button('Edit')
      expect(current_path).to eq("/quotes/#{@quote.id}/edit")

      fill_in('project_scope', with: "Edited")
      click_button('Submit')

      expect(current_path).to eq('/quotes')
      expect(page).to have_content('Edited')
    end
  end

  feature 'The quote must be filled in completely' do
    scenario 'quote does not have all the information' do 
      visit('/quotes/new')
      fill_in('client_id', with: "11")
      click_button('Submit')
      expect(page).to have_content("Please fill in all fields")
    end
  end
end