Feature: Contact Message Creation
  In order for users to communicate
  As a registered user of the website
  I want to be able to send messages to people whom are my contacts

  Background:
    Given I am a user with an email "greg@test.com" and password "please"
    And There is a user with an email "reid@test.com" and password "please"
    And There is a user with an email "amol@test.com" and password "please"
    And I have the username "GregT"
    And The user with the email "reid@test.com" has the username "ReidH"
    And The user with the email "amol@test.com" has the username "AmolK"
    And The following users are contacts:
    | GregT |
    | ReidH |
    | AmolK |
	  When I sign in as "greg@test.com/please"    
    And I follow "Mailbox"
    And I follow "New Message"
  
  Scenario: Sent message is in outbox
    When I fill in the following:
        |	To		   | ReidH           |
        |	Subject  | foo             |
        |	Body     | bar			       |
    And I press "Send"
    And I follow "Mailbox"
    Then I should have message "foo" in my outbox

  Scenario: I can read messages in my outbox
    When I fill in the following:
        |	To		   | ReidH           |
        |	Subject  | foo             |
        |	Body     | bar			       |
    And I press "Send"
    And I follow "Mailbox"
    And I follow "foo"
    Then I should see "bar"

  Scenario: Sent message is in other's inbox
    When I fill in the following:
        |	To		   | ReidH           |
        |	Subject  | foo             |
        |	Body     | bar			       |
    And I press "Send"
	  And I sign out
	  And I sign in as "reid@test.com/please"
	  And I follow "Mailbox"
	  Then I should have message "foo" in my inbox
    
  Scenario: Sent message to multiple users inboxes
    When I fill in the following:
        |	To		   | ReidH, AmolK    |
        |	Subject  | foo             |
        |	Body     | bar			       |
    And I press "Send"
	  And I sign out
	  And I sign in as "reid@test.com/please"
	  And I follow "Mailbox"
	  Then I should have message "foo" in my inbox
    When I sign out
	  And I sign in as "amol@test.com/please"
	  And I follow "Mailbox"
	  Then I should have message "foo" in my inbox
    
    
  Scenario: Users can read mail in their inbox
    When I fill in the following:
        |	To		   | ReidH           |
        |	Subject  | foo             |
        |	Body     | bar			       |
    And I press "Send"
	  And I sign out
	  And I sign in as "reid@test.com/please"
	  And I follow "Mailbox"
	  And I follow "foo"
    Then I should see "bar"
    
  Scenario: Users do not send messages to people whom are not contacts
    Given There is a user with an email "deepak@test.com" and password "please"
    And The user with the email "deepak@test.com" has the username "DeepakS"
    When I fill in the following:
        |	To		   | DeepakS         |
        |	Subject  | foo             |
        |	Body     | bar			       |
    And I press "Send"
	  And I follow "Mailbox"
	  Then I should not see "foo"