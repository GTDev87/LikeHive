Feature: User Inbox
  In order for users to communicate
  As a registered user of the website
  I want to receive messages

  Scenario: Viewing incoming messages
    Given I am a user with an email "greg@test.com" and password "please"
    And There is a user with an email "reid@test.com" and password "please"
    And "greg@test.com" has a message sent from "reid@test.com" to "greg@test.com" with subject "foo" and body "bar"
    When I sign in as "greg@test.com/please"    
    And I follow "Mailbox"
    Then I should have message "foo" in my inbox