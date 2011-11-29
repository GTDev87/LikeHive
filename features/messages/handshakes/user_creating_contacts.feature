Feature: User extending Handshakes
  In order to make new friends
  As a registered user of the website
  I keep track of contacts who have accepted my handshakes
  
  Scenario: Accepted contacts can be seen by user accepting handshake
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
    And I press "Accept Handshake"
    And I follow "Profile"
    Then User "GregT" should be one of my contacts
    
  Scenario: Accepted contacts can be seen by user asking for handshake
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
    And I press "Accept Handshake"
    And I sign out
    And I sign in as "greg@test.com/please"
    Then User "UserA" should be one of my contacts