Feature: User extending Handshakes
  In order to make new friends
  As a registered user of the website
  I extend handshakes to other users
      
    Scenario: Shows common interest between yourself recommendation
      Given There is a user with an email "a@test.com" and password "pizza"
      And The user with email "a@test.com" likes "pizza"
      And The user with the email "a@test.com" has the username "UserA"
      And I am a user with an email "greg@greg.com" and password "please"
      And I like "pizza"
      When I sign in as "greg@greg.com/please"
      And I press "Handshake UserA"