Given /^I am on the home page$/ do
  visit root_path
  page.should have_content('Dctrs')
end

Given /^a provider with last name 'Seuss'$/ do
  create :seuss
end

When /^I search for "([^"]*)"$/ do |query|
  within('.form-search') do
    fill_in 'query', with: query
    click_button 'Search'
  end
end

Then /^I should be on the seach results page$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see the provider with last name'Seuss'$/ do
  pending # express the regexp above with the code you wish you had
end
