Feature: Add Likes
  In order to keep track of my interests
  As a registered user of the website
  I want to add likes


    Scenario: Seeing likes
      Given I am a user with an email "greg@test.com" and password "please"
      And I have a like "pizza"
      And I have a like "breadsticks"
      When I sign in as "greg@test.com/please"
      Then I should see "Pizza"
      And I should see "Breadsticks"

    Scenario: Adding likes
      Given I am a user with an email "greg@test.com" and password "please"
      When I sign in as "greg@test.com/please"
      And I fill in "user_virtual_like_name" with "Pony"
      And I press "Add Like"
      Then I should see "Pony"
      
    Scenario: Adding multiple likes
      Given I am a user with an email "greg@test.com" and password "please"
      When I sign in as "greg@test.com/please"
      And I fill in "user_virtual_like_name" with "Cucumbers"
      And I press "Add Like"
      And I fill in "user_virtual_like_name" with "Cheese"
      And I press "Add Like"
      Then I should see "Cucumbers"
      Then I should see "Cheese"
      
    Scenario: Likes are capitalized
      Given I am a user with an email "greg@test.com" and password "please"
      When I sign in as "greg@test.com/please"
      And I fill in "user_virtual_like_name" with "cUcUmBeRs"
      And I press "Add Like"
      Then I should see "Cucumbers"
      
    Scenario: Adding likes with leading and trailing spaces the same like
      Given I am a user with an email "greg@test.com" and password "please"
      When I sign in as "greg@test.com/please"
      And I fill in "user_virtual_like_name" with " potato"
      And I press "Add Like"
      And I fill in "user_virtual_like_name" with "potato "
      And I press "Add Like"
      Then I should see "Likes (1):"
      Then I should see "Potato"
      
    Scenario: "No Likes" is displayed with user has no likes
      Given I am a user with an email "greg@test.com" and password "please"
      When I sign in as "greg@test.com/please"
      Then I should see "No Likes"
      
    Scenario: Blank Likes are not created program does not crash
      Given I am a user with an email "greg@test.com" and password "please"
      When I sign in as "greg@test.com/please"
      And I fill in "user_virtual_like_name" with " "
      And I press "Add Like"
      Then I should see "No Likes"
      
    Scenario: Empty Likes are not created program does not crash
      Given I am a user with an email "greg@test.com" and password "please"
      When I sign in as "greg@test.com/please"
      And I fill in "user_virtual_like_name" with ""
      And I press "Add Like"
      Then I should see "No Likes"
