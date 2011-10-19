Feature: User Page
  As a registered user of the website
  I want my user's sessions separate
  so my data is private to myself

    Scenario: I can't see other's account get access denied
      Given I am a user with an email "greg@test.com" and password "please"
      And I have first name "Greg" and last initial "T"
      And There is a user with an email "Zac@test.com" and password "please"
      And the email "Zac@test.com" has the user name "Zac"
      When I sign in as "greg@test.com/please"
      When I follow "zac@test.com"
      Then I should see "Access Denied"
      
    Scenario: I can't see other's account redirect to signup
      Given I am a user with an email "greg@test.com" and password "please"
      And I have first name "Greg" and last initial "T"
      And There is a user with an email "Zac@test.com" and password "please"
      And the email "Zac@test.com" has the user name "Zac"
      When I sign in as "greg@test.com/please"
      When I follow "zac@test.com"
      Then I should see "Log in"
      And I should see "Email"
      And I should see "Password"
      And I should see "Remember me"