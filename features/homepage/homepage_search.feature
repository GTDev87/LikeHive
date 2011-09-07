Feature: Show Like
  As a visitor to the website
  I want 
  To be able to search for information about people's likes


    Scenario: Searching Likes
      Given I am not logged in
      And I am on the home page
      And There is a like named "Sunshine"
      When I fill in "like_search" with "Sunshine"
      And I press "Search"
      Then I should see "Sunshine"