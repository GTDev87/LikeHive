Feature: Message Creation
  In order for users to communicate
  As a registered user of the website
  I want to be able to create messages

  Background:
    Given I am a user with an email "greg@test.com" and password "please"
    And There is a user with an email "reid@test.com" and password "please"
	  When I sign in as "greg@test.com/please"    
    And I follow "Mailbox"
    And I follow "New Message"    
    And I fill in the following:
        |	To		   | reid@test.com   |
        |	Subject  | foo             |
        |	Body     | bar			       |
    And I press "Send"
  
  Scenario: Sent message is in outbox
    When I follow "Mailbox"
    Then I should have message "foo" in my outbox

  Scenario: I can read messages in my outbox
    When I follow "Mailbox"
    And I follow "foo"
    Then I should see "bar"

  Scenario: Sent message is in other's inbox
	  When I sign out
	  And I sign in as "reid@test.com/please"
	  And I follow "Mailbox"
	  Then I should have message "foo" in my inbox
    
  Scenario: Users can read mail in their inbox
	  When I sign out
	  And I sign in as "reid@test.com/please"
	  And I follow "Mailbox"
	  And I follow "foo"
    Then I should see "bar"