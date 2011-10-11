Feature: Show Like Page
  As a visitor to the website
  I want to see a like
  so I can know the site has likes


    Scenario: Viewing likes
      Given There is a like named "fish"
      When I look at the "fish" like page
      Then I should see "Fish"
      
    Scenario: Viewing multi word likes
      Given There is a like named "flying fish"
      When I look at the "flying-fish" like page
      Then I should see "Flying Fish"
      
    Scenario: Seeing users on likes page
      Given There is a user with an email "Greg@test.com" and password "OhThatGreg"
      And The user with email "Greg@test.com" likes "Pizza" 
      When I look at the "pizza" like page
      Then I should see "greg@test.com"
      
    Scenario: Seeing no users on likes page
      Given There is a like named "pizza"
      Given Nobody likes "pizza"
      When I look at the "pizza" like page
      Then I should see "No Users"
      
    Scenario: Adding and seeing self on other likes page (end to end)
      Given I am a user with an email "greg@test.com" and password "please"
      When I sign in as "greg@test.com/please"
      And I follow "greg@test.com"
      And I fill in "user_like_name" with "sunny days"
      And I press "Add Like"
      And I fill in "user_like_name" with "chocolate"
      And I press "Add Like"
      And I follow "Sunny Days"
      Then I should see "Users (1)"
      
    Scenario: Adding and seeing self on other likes page (end to end stress)
      Given I am a user with an email "greg@test.com" and password "please"
      When I sign in as "greg@test.com/please"
      And I follow "greg@test.com"
      And I fill in "user_like_name" with "like 1"
      And I press "Add Like"
      And I fill in "user_like_name" with "Like 2"
      And I press "Add Like"
      And I fill in "user_like_name" with "Like 3"
      And I press "Add Like"
      And I fill in "user_like_name" with "Like 4"
      And I press "Add Like"
      And I fill in "user_like_name" with "Like 5"
      And I press "Add Like"
      And I fill in "user_like_name" with "Like 6"
      And I press "Add Like"
      And I fill in "user_like_name" with "Like 7"
      And I press "Add Like"
      And I follow "Like 3"
      Then I should see "Users (1"
      
      