@search
Feature: Search Like Home
  As a visitor to the website
  I want 
  To be able to search for information about people's likes

  Scenario: Searching Likes
    Given I am not logged in
    And I am on the home page
    And There is a like named "sunshine"
    When I fill in "search" with "Sunshine"
    And I press "Search"
    Then I should see "Sunshine"
    
  Scenario: User signs in successfully on home page
      Given I am not logged in
      And I am a user with an email "user@test.com" and password "please"
      When I fill in the following:
      | Email     | user@test.com |
      | password  | please        |
      And press "Log in"
      Then I should see "Signed in successfully."
      And I should be signed in
      When I return next time
      Then I should be already signed in