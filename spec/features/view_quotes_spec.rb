require 'sqlite3'

feature 'View quotes' do
  scenario 'A user can view all the quotes' do
    @connection = SQLite3::Database.new "project_org_test.db"

    @connection.execute("INSERT INTO quotes (date_created, client_id, project_scope, materials_table, labour_table, expenses_table) VALUES('01/09/2021', '3', 'Project scope 3', 'mt3', 'lt3', 'et3');")

    visit('/quotes')

    expect(page).to have_content("01/09/2021")
    expect(page).to have_content("3")
    expect(page).to have_content("Project scope 3")
    expect(page).to have_content("mt3")
    expect(page).to have_content("lt3")
    expect(page).to have_content("et3")
  end
end