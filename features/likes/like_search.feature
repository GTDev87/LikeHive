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
      
    Scenario: Searching should not return anything if blank is entered
      Given I am not logged in
      And I am on the likes page
      And There is a like named "catfish"
      When I fill in "search" with " "
      And I press "Search"
      Then I should not see "Catfish"  
      
    Scenario: Searching should not return more than 10 results
      Given I am not logged in
      And I am on the likes page
      And There is a like named "Like 1"
      And There is a like named "Like 2"
      And There is a like named "Like 3"
      And There is a like named "Like 4"
      And There is a like named "Like 5"
      And There is a like named "Like 6"
      And There is a like named "Like 7"
      And There is a like named "Like 8"
      And There is a like named "Like 9"
      And There is a like named "Like 10"
      And There is a like named "Like 11"
      And There is a like named "Like 12"
      And There is a like named "Like 13"
      And There is a like named "Like 14"
      And There is a like named "Like 15"
      When I fill in "search" with "Like"
      And I press "Search"
      Then I should see "Like 1"
      Then I should see "Like 2"
      Then I should see "Like 3"
      Then I should see "Like 4"
      Then I should see "Like 5"
      Then I should see "Like 6"
      Then I should see "Like 7"
      Then I should see "Like 8"
      Then I should see "Like 9"
      Then I should see "Like 10"
      Then I should not see "Like 11"
      Then I should not see "Like 12"
      Then I should not see "Like 13"
      Then I should not see "Like 14"
      Then I should not see "Like 15"