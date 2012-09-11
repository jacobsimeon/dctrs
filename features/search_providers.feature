Feature: Search Providers 
  In order to save time for users
  As a user
  I want to search for providers by name, npin and other attributes

  Scenario: Search for an individual provider by last name
    Given I am on the home page
    And an individual provider with last name "Seuss"
    And an individual provider with last name "Morris"
    When I search for "Seuss"
    Then I should be on the search results page
    And I should see the provider with last name "Seuss"
    And I should not see the provider with last name "Morris"

  Scenario: Search for a provider by first name
    Given I am on the home page
    And an individual provider with first name "Jacob"
    And an individual provider with first name "John"
    When I search for "Jacob"
    Then I should be on the search results page
    And I should see the provider with first name "Jacob"
    And I should not see the provider with first name "John"

  Scenario: Search for a provider by organization name
    Given I am on the home page
    And a provider organization with legal business name "St. Lukes Hospital"
    And a provider organization with legal business name "St. Alphonsus Hospital"
    When I search for "Lukes"
    Then I should be on the search results page
    And I should see the provider with name "St. Lukes Hospital"
    And I should not see the provider with name "St. Alphonsus Hospital"

  Scenario: Search for a provider by specialty
    Given I am on the home page
    And a provider with specialty "Orthopaedic Surgery"
    When I search for "Orthopaedic"
    Then I should be on the search results page
    Then I should see the provider with specialty "Orthopaedic Surgery"

