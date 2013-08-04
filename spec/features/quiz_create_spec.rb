feature "Creating a quiz" do
  scenario "Landing on the root page without being logged in" do
    visit "/"
    expect(page).to have_css("form.new_statement")
  end
end
