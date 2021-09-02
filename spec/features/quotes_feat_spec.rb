require 'sqlite3'

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
end