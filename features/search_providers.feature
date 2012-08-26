Feature: Search Providers 
  In order to save time for users
  As a user
  I want to search for providers by name, npin and other attributes

  Scenario: Search for a provider by last name
    Given I am on the home page
    And a provider with last name 'Seuss'
    When I search for "Seu"
    Then I should be on the search results page
    And I should see the provider with last name 'Seuss'

  Scenario: Search for a provider by first name
    Given I am on the home page
    And a provider with first name 'Jacob'
    When I search for "Jac"
    Then I should be on the search results page
    And I should see the provider with first name 'Jacob'
