Feature: Search Providers 
  In order to save time for users
  As a user
  I want to search for providers by name, npin and other attributes

  Scenario: Search for a provider by last name
    Given I am on the home page
    And a provider with last name 'Seuss'
    And I search for 'Seu'
    Then I should be on the seach results page
    And I should see the provider with last name'Seuss'
