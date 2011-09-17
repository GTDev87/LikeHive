Feature: User Page
  As a registered user of the website
  I want see my user profile
  so I can view my profile

    Scenario: I see my account
      Given I am a user with the following:
      | first_name  | email         | password  | 
      | Greg        | greg@test.com | please    |
      When I sign in as "greg@test.com/please"
      Then I should be signed in
      When I follow "greg@test.com"
      Then I should see "User: Greg"
      And I should see "Email: greg@test.com"