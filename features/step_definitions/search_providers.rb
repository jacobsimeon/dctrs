Given /^I am on the home page$/ do
  visit root_path
  page.should have_content('Dctrs')
end

Given /^a provider with last name 'Seuss'$/ do
  create :seuss
end

Given /^a provider with first name 'Jacob'$/ do
  create :jacob
end

When /^I search for "([^"]*)"$/ do |query|
  Provider.refresh_index
  within('.form-search') do
    fill_in 'query', with: query
    click_button 'Search'
  end
end

Then /^I should be on the search results page$/ do
  current_path.should == search_path
end

Then /^I should see the provider with last name 'Seuss'$/ do
  within('div.providers') do
    page.should have_content 'Seuss'
  end
end

Then /^I should see the provider with first name 'Jacob'$/ do
  within('div.providers') do
    page.should have_content 'Jacob'
  end
end
