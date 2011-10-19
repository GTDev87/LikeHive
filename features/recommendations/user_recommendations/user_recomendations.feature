Feature: User Recomendations
  In order meet people like myself
  As a registered user of the website
  I want person recomendations
  
  Background:
    Given There are the following users:
    |User1A  |
    |User2B  |
    |User3C  |
    |User4D  |
    |User5E  |
    |User6F  |
    |User7G  |
      
    Scenario: Seeing 5 User Recomendations
      Given I am a user with an email "greg@greg.com" and password "please"
      When I sign in as "greg@greg.com/please"
      And I follow "greg@greg.com"
      Then I should see the following:
      |Suggested 1|
      |Suggested 2|
      |Suggested 3|
      |Suggested 4|
      |Suggested 5|
      