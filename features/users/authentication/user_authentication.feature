Feature: User Authentication
  As a registered user of the website
  I want my user's sessions separate
  so my data is private to myself

    Scenario: I can't see other's account get access denied
      Given I am a user with an email "greg@test.com" and password "please"
      And I have first name "Greg" and last initial "T"
      And There is a user with an email "zac@test.com" and password "please"
      And the email "zac@test.com" has the user name "Zac"
      When I sign in as "greg@test.com/please"
      And I navigate to the user "zac-at-test-period-com" page
      Then I should see "Access Denied"
      
    Scenario: I can't see other's account when not signed in
      Given There is a user with an email "zac@test.com" and password "please"
      And the email "zac@test.com" has the user name "Zac"
      When I navigate to the user "zac-at-test-period-com" page
      Then I should see "Access Denied"