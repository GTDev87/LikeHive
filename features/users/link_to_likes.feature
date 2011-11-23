Feature: Link To Likes
  In order to keep track of my interests
  As a user on my profile page
  I link to the likes page of my likes
  
    Scenario: Linking to likes
      Given I am a user with an email "greg@test.com" and password "please"
      When I sign in as "greg@test.com/please"
      And I fill in "user_virtual_like_name" with "Cucumbers"
      And I press "Add Like"
      And I follow "Cucumbers"
      Then I should see "Cucumbers"
      
    Scenario: Linking to multi word likes
      Given I am a user with an email "greg@test.com" and password "please"
      When I sign in as "greg@test.com/please"
      And I fill in "user_virtual_like_name" with "sunny days"
      And I press "Add Like"
      And I follow "Sunny Days"
      Then I should see "Sunny Days"
      
      