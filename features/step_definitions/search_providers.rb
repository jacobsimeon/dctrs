Given /^I am on the home page$/ do
  visit root_path
  page.should have_content('Dctrs')
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

Given /^an individual provider with last name "(.*?)"$/ do |last_name|
  IndividualProvider.create :name_attributes => { :last => last_name }
end

Given /^an individual provider with first name "(.*?)"$/ do |first_name|
  IndividualProvider.create :name_attributes => { :first => first_name }
end

Then /^I should see the provider with last name "(.*?)"$/ do |last_name|
  within('div.providers') do
    page.should have_content last_name
  end
end

Then /^I should see the provider with first name "(.*?)"$/ do |first_name|
  within('div.providers') do
    page.should have_content first_name
  end
end

Then /^I should not see the provider with last name "(.*?)"$/ do |last_name|
  within('div.providers') do
    page.should_not have_content last_name
  end
end

Then /^I should not see the provider with first name "(.*?)"$/ do |first_name|
  within('div.providers') do
    page.should_not have_content first_name
  end
end

Given /^a provider organization with legal business name "(.*?)"$/ do |business_name|
  ProviderOrganization.create name_attributes: { legal_business_name: business_name }
end

Then /^I should see the provider with name "(.*?)"$/ do |arg1|
  within('div.providers') do
    page.should have_content arg1
  end
end

Then /^I should not see the provider with name "(.*?)"$/ do |content|
  within('div.providers') do
    page.should_not have_content content
  end
end

Given /^a provider with specialty "(.*?)"$/ do |arg1|
    pending # express the regexp above with the code you wish you had
end

Then /^I should see the provider with specialty "(.*?)"$/ do |arg1|
    pending # express the regexp above with the code you wish you had
end
