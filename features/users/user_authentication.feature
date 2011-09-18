Feature: User Page
  As a registered user of the website
  I want my user's sessions separate
  so my data is private to myself

    Scenario: I can't see other's account
      Given I am a user with the following:
      | first_name  | email         | password  | 
      | Greg        | greg@test.com | please    |
      And The following user:
      | first_name  | email         | password  | 
      | Zac         | Zac@test.com  | please    |
      When I sign in as "greg@test.com/please"
      When I follow "zac@test.com"
      Then I should see "Access Denied"