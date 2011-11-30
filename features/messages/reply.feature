Feature: Replying to messages
  In order for users to communicate
  As a registered user of the website
  I want to reply to messages I have received

  Scenario: Viewing incoming messages
    Given I am a user with an email "greg@test.com" and password "please"
    And There is a user with an email "reid@test.com" and password "please"
    And The user with the email "reid@test.com" has the username "ReidH"
    And The user with the email "greg@test.com" has the username "GregT"
    And The following users are contacts:
    | GregT |
    | ReidH |
    And "greg@test.com" has a message sent from "reid@test.com" to "greg@test.com" with subject "foo" and body "bar"
    When I sign in as "greg@test.com/please"    
    And I follow "Mailbox"
    And I follow "foo"
    And I follow "Reply"
    Then I should be about to send a message to "ReidH"
    And I should be about to send a message with the subject "foo"
    And I should be about to send a message with body "bar"
    