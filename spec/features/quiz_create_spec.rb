feature "Creating a quiz" do
  scenario "Creating a quiz without being logged in" do
    visit "/"

    # First page should have the "new statement" form without a radio button
    within('form.new_statement') do
      expect(page).not_to have_css('input[type=radio]')
    end

    fill_in 'statement[text]', :with => 'first statement'
    click_button 'Create Statement'

    # Second page should also have the "new statement" form without a radio button
    within('form.new_statement') do
      expect(page).not_to have_css('input[type=radio]')
    end

    # Second page should include a list of existing statements, which should
    # include the first statement.
    within('.statements') do
      expect(page).to have_content('(truth) first statement')
    end

    fill_in 'statement[text]', :with => 'second statement'
    click_button 'Create Statement'

    # Third page should have the "new statement" form with radio buttons for
    # truths and lies.
    within('form.new_statement') do
      expect(page).to have_css('input[type=radio][name="statement[truth]"][value=true]')
      expect(page).to have_css('input[type=radio][name="statement[truth]"][value=false]')
    end

    # List of statements should now include both, and the second should be a
    # lie.
    within('.statements') do
      expect(page).to have_content('(truth) first statement')
      expect(page).to have_content('(lie) second statement')
    end

    fill_in 'statement[text]', :with => 'third statement'
    click_button 'Create Statement'

    # List of statements should include the new statement, which defaulted to a
    # truth.
    within('.statements') do
      expect(page).to have_content('(truth) third statement')
    end

    fill_in 'statement[text]', :with => 'fourth statement'
    choose 'lie'
    click_button 'Create Statement'

    # List of statements should include the new statement, which was manually
    # chosen to be a lie.
    within('.statements') do
      expect(page).to have_content('(lie) fourth statement')
    end
  end
end
