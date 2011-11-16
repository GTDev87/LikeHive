Feature: Replying to messages
  In order for users to communicate
  As a registered user of the website
  I want to reply to messages I have received

  Scenario: Viewing incoming messages
    Given I am a user with an email "greg@test.com" and password "please"
    And There is a user with an email "reid@test.com" and password "please"
    And "greg@test.com" has a message sent from "reid@test.com" to "greg@test.com" with subject "foo" and body "bar"
    When I sign in as "greg@test.com/please"    
    And I follow "Mailbox"
    And I follow "foo"
    And I follow "Reply"
    Then I should see "greg@test.com"
    And I should see "reid@test.com"
    And I should see "foo"