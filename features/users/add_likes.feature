Feature: Add Likes
  As a registered user of the website
  I want to edit my user profile
  so I add likes to my user text field

    Scenario: Adding likes
      Given I am a user named "foo" with an email "user@test.com" and password "please"
      When I sign in as "user@test.com/please"
      Then I can add "Pizza" to my list of likes