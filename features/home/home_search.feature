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