Feature: User Recomendations
  In order meet people like myself
  As a registered user of the website
  I want person recomendations
  
  Background:
      
    Scenario: Seeing 5 User Recomendations
      Given There are the following users:
      |a@test.com  |
      |b@test.com  |
      |c@test.com  |
      |d@test.com  |
      |e@test.com  |
      |f@test.com  |
      |g@test.com  |
      And I am a user with an email "greg@greg.com" and password "please"
      When I sign in as "greg@greg.com/please"
      And I follow "greg@greg.com"
      Then I should see the following:
      |Suggested 1|
      |Suggested 2|
      |Suggested 3|
      |Suggested 4|
      |Suggested 5|
      
    Scenario: Shows common interest between yourself recommendation
      Given There is a user with an email "a@test.com" and password "pizza"
      And The user with email "a@test.com" likes "pizza"
      And I am a user with an email "greg@greg.com" and password "please"
      And I like "pizza"
      When I sign in as "greg@greg.com/please"
      And I follow "greg@greg.com"
      Then I should see a recommended user with:
      |Suggested 1      |
      |Common Interests |
      |Pizza            |