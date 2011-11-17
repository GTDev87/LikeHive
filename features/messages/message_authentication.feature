Feature: Message Authentication
  In order for users to have protected communications
  As a registered user of the website
  I my messages to not be viewd by others

  Background:
    Given I am a user with an email "greg@test.com" and password "please"
    And There is a user with an email "reid@test.com" and password "please"
    And The user with the email "reid@test.com" has the username "ReidH"
    And There is a user with an email "amol@test.com" and password "please"
	  When I sign in as "greg@test.com/please"    
    And I follow "Mailbox"
    And I follow "New Message"    
    And I fill in the following:
        |	To		   | ReidH           |
        |	Subject  | foo             |
        |	Body     | bar			       |
    And I press "Send"
    And I sign out
  
  Scenario: Cannot access message after signout
    When I visit the message page with subject "foo"
    Then I should not see "bar"
    And I should see "Access Denied"
    
  Scenario: Cannot access message signed in as another user
    When I sign in as "amol@test.com/please"
	  And I visit the message page with subject "foo"
    Then I should not see "bar"
    And I should see "Access Denied"