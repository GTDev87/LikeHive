Feature: User Page
  As a registered user of the website
  I want my user's sessions separate
  so my data is private to myself

    Scenario: I can't see other's account
      Given I am a user with the following:
      | email         | password  | 
      | greg@test.com | please    |
      And I have the following user name:
      | first       |
      | Greg        |
      And The following user:
      | email         | password  | 
      | Zac@test.com  | please    |
      And the email "Zac@test.com" has the user name "Zac"
      When I sign in as "greg@test.com/please"
      When I follow "zac@test.com"
      Then I should see "Access Denied"