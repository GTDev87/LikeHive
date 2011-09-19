Feature: User Page
  As a registered user of the website
  I want see my user profile
  so I can view my profile

    Scenario: I see my account
      Given I am a user with the following:
      | first_name  | email         | password  | last_initial  | female  |
      | Greg        | greg@test.com | please    | T             | false   |
      When I sign in as "greg@test.com/please"
      Then I should be signed in
      When I follow "greg@test.com"
      Then I should see "User: Greg T."
      Then I should see "Gender: Male"
      And I should see "Email: greg@test.com"
      
    Scenario: Displays Gender Correctly
      Given I am a user with the following:
      | female  | email         | password  |
      | true    | greg@test.com | please    |
      When I sign in as "greg@test.com/please"
      Then I should be signed in
      When I follow "greg@test.com"
      Then I should see "Gender: Female"
      
    Scenario: Displays Name Correctly
      Given I am a user with the following:
      | first_name  | last_initial  | email         | password  |
      | Greg        | T             | greg@test.com | please    |
      When I sign in as "greg@test.com/please"
      Then I should be signed in
      When I follow "greg@test.com"
      Then I should see "User: Greg T."
      
    Scenario: Displays Email Correctly
      Given I am a user with the following:
      | email         | password  |
      | greg@test.com | please    |
      When I sign in as "greg@test.com/please"
      Then I should be signed in
      When I follow "greg@test.com"
      Then I should see "Email: greg@test.com"
      
      