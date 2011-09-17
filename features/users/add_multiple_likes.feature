Feature: Add Multiple Likes
  In order to keep track of my interests
  As a registered user of the website
  I want add multiple likes at once
  
    Scenario: Adding multiple likes
      Given I am a user with an email "greg@test.com" and password "please"
      When I sign in as "greg@test.com/please"
      And I follow "greg@test.com"
      And I fill in "user_like_box" with "pizza, breadsticks"
      And I press "Add Likes"
      Then I should see "Pizza"
      And I should see "Breadsticks"
      
    Scenario: Adding likes with starting and trailing spaces
      Given I am a user with an email "greg@test.com" and password "please"
      When I sign in as "greg@test.com/please"
      And I follow "greg@test.com"
      And I fill in "user_like_box" with " tomato, tomato "
      And I press "Add Likes"
      Then I should see "Likes (1):"
      And I should see "Tomato"
      
    Scenario: Adding multiple multi word likes
      Given I am a user with an email "greg@test.com" and password "please"
      When I sign in as "greg@test.com/please"
      And I follow "greg@test.com"
      And I fill in "user_like_box" with "red fish, blue fish"
      And I press "Add Likes"
      Then I should see "Red Fish"
      And I should see "Blue Fish"