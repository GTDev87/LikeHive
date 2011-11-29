Feature: User Recomendations
  In order meet people like myself
  As a registered user of the website
  I want person recomendations
      
  Scenario: Shows common interest between yourself recommendation
    Given There is a user with an email "a@test.com" and password "pizza"
    And The user with the email "a@test.com" has the username "UserA"
    And The user with email "a@test.com" likes "pizza"
    And I am a user with an email "greg@greg.com" and password "please"
    And I like "pizza"
    When I sign in as "greg@greg.com/please"
    Then I should see a recommended user with:
    |Suggested 1      |
    |Common Interests |
    |Pizza            |
    
  Scenario: Shows common interest between yourself recommendation
    Given There is a user with an email "a@test.com" and password "pizza"
    And The user with the email "a@test.com" has the username "UserA"
    And The user with email "a@test.com" likes "pizza"
    And I am a user with an email "greg@greg.com" and password "please"
    And I have a contact of "UserA"
    And I like "pizza"
    When I sign in as "greg@greg.com/please"
    Then I should not see a recommended user with:
    |Suggested 1      |
    |Common Interests |
    |Pizza            |