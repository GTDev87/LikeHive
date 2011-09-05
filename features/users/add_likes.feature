Feature: Add Likes
  In order to keep track of my interests
  As a registered user of the website
  I want to see the list of likes I have


    Scenario: Seeing likes
      Given I am a user named "greg" with an email "greg@test.com" and password "please"
      And I have a like "Pizza"
      And I have a like "Breadsticks"
      When I sign in as "greg@test.com/please"
      When I follow "greg"
      Then I should see "Pizza"
      And I should see "Breadsticks"

    Scenario: Adding likes
      Given I am a user named "greg" with an email "greg@test.com" and password "please"
      When I sign in as "greg@test.com/please"
      And I follow "greg"
      And I fill in "user_like_name" with "Pony"
      And I press "Add Like"
      Then I should see "Pony"
      
    Scenario: Adding multiple likes
      Given I am a user named "greg" with an email "greg@test.com" and password "please"
      When I sign in as "greg@test.com/please"
      And I follow "greg"
      And I fill in "user_like_name" with "Cucumbers"
      And I press "Add Like"
      And I fill in "user_like_name" with "Cheese"
      And I press "Add Like"
      Then I should see "Cucumbers"
      Then I should see "Cheese"
