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
    |User8H  |
    |User9I  |
    |User10J |
    |User11K |
    |User12L |
    |User13M |
    |User14N |
    |User15O |
      
    Scenario: Seeing 5 User Recomendations
      Given I am a user with an email "greg@greg.com" and password "please"
      When I sign in as "greg@greg.com/please"
      And I follow "greg@greg.com"
      Then I should see 5 of the following:
      |User1A  |
      |User2B  |
      |User3C  |
      |User4D  |
      |User5E  |
      |User6F  |
      |User7G  |
      |User8H  |
      |User9I  |
      |User10J |
      |User11K |
      |User12L |
      |User13M |
      |User14N |
      |User15O |