Feature: Message Creation
  In order for users to communicate
  As a registered user of the website
  I want to be able to create messages

  Scenario: Sent message is in outbox
    Given I am a user with an email "greg@test.com" and password "please"
    And There is a user with an email "reid@test.com" and password "please"
	When I sign in as "greg@test.com/please"    
    And I follow "Mailbox"
    And I follow "New Message"    
    And I fill in the following:
        |	To		| reid@test.com	|
        |	Subject	| foo			|
        |	Body	| bar			|
	And I press "Send"
	And I follow "Mailbox"
    Then I should have message "foo" in my outbox

  Scenario: Sent message is in other's inbox
	Given I am a user with an email "greg@test.com" and password "please"
	And There is a user with an email "reid@test.com" and password "please"
	When I sign in as "greg@test.com/please"    
    And I follow "Mailbox"
    And I follow "New Message"    
	And I fill in the following:
		|	To		| reid@test.com	|
	    |	Subject	| foo			|
	    |	Body	| bar			|
	And I press "Send"
	And I sign out
	And I sign in as "reid@test.com/please"
	And I follow "Mailbox"
	Then I should have message "foo" in my inbox