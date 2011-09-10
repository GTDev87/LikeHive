@search
Feature: Search Like Page
  As a visitor to the website
  I want 
  To be able to search for information about people's likes from the likes index


    Scenario: Searching Likes
      Given I am not logged in
      And I am on the likes page
      And There is a like named "sunshine"
      When I fill in "search" with "Sunshine"
      And I press "Search"
      Then I should see "Sunshine"
      
    Scenario: Searching Likes case insensitive
      Given I am not logged in
      And I am on the likes page
      And There is a like named "flowers"
      When I fill in "search" with "fLoWeRs"
      And I press "Search"
      Then I should see "Flowers"
      
    Scenario: Searching should return multiple results
      Given I am not logged in
      And I am on the likes page
      And There is a like named "flowers"
      And There is a like named "pretty flowers"
      When I fill in "search" with "fLoWeRs"
      And I press "Search"
      Then I should see "Flowers"
      Then I should see "Pretty Flowers"
      
    Scenario: Searching should not return partial word likes
      Given I am not logged in
      And I am on the likes page
      And There is a like named "catfish"
      When I fill in "search" with "fish"
      And I press "Search"
      Then I should not see "Catfish"
      
    Scenario: Searching should not return anything if nothing is entered
      Given I am not logged in
      And I am on the likes page
      And There is a like named "catfish"
      When I fill in "search" with ""
      And I press "Search"
      Then I should not see "Catfish"  