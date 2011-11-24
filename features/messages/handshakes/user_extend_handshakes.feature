Feature: User extending Handshakes
  In order to make new friends
  As a registered user of the website
  I extend handshakes to other users
      
  Scenario: Handshake button exists
    Given There is a user with an email "a@test.com" and password "please"
    And The user with the email "a@test.com" has the username "UserA"
    And I am a user with an email "greg@greg.com" and password "please"
    And I like "pizza"
    When I sign in as "greg@greg.com/please"
    And I press "Handshake UserA"
    Then I should see "Handshake Sent"
    
  Scenario: Handshake's are sent
    Given There is a user with an email "a@test.com" and password "please"
    And The user with the email "a@test.com" has the username "UserA"
    And I am a user with an email "greg@test.com" and password "please"
    And I have the username "GregT"
    When I sign in as "greg@test.com/please"
    And I press "Handshake UserA"
    And I follow "Mailbox"
    And I follow "[Handshake Extended] GregT"
    Then I should see "[Handshake Extended] GregT"
    And I should see "UserA"
  
  Scenario: Handshake's are received
    Given There is a user with an email "a@test.com" and password "please"
    And The user with the email "a@test.com" has the username "UserA"
    And I am a user with an email "greg@test.com" and password "please"
    And I have the username "GregT"
    When I sign in as "greg@test.com/please"
    And I press "Handshake UserA"
    And I sign out
    And I sign in as "a@test.com/please"
    And I follow "Mailbox"
    And I follow "[Handshake Extended] GregT" 
    Then I should see "[Handshake Extended] GregT"
    And I should see "UserA"