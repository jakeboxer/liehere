feature "Creating a quiz" do
  scenario "Creating a quiz without being logged in" do
    visit "/"

    # First page should have the "new statement" form
    expect(page).to have_css("form.new_statement")

    fill_in 'statement[text]', :with => 'first statement'
    click_button 'Create Statement'

    # Second page should also have the "new statement" form
    expect(page).to have_css("form.new_statement")

    # Second page should include a list of existing statements, which should
    # include the first statement.
    within('.statements') do
      expect(page).to have_content('(truth) first statement')
    end

    fill_in 'statement[text]', :with => 'second statement'
    click_button 'Create Statement'

    # List of statements should now include both, and the second should be a
    # lie.
    within('.statements') do
      expect(page).to have_content('(truth) first statement')
      expect(page).to have_content('(lie) second statement')
    end
  end
end
