Feature: Edit User
  As a registered user of the website
  I want to edit my user profile
  so I can change my username

    Scenario: I sign in and edit my account
      Given I am a user with an email "user@test.com" and password "please"
      When I sign in as "user@test.com/please"
      Then I should be signed in
      When I follow "Edit account"
      And I fill in "First name" with "baz"
      And I fill in "Current password" with "please"
      And I select "T" in "Last initial"
      And choose "Female"
      And I press "Update"
      And I follow "user@test.com"
      Then I should see "User: baz T."
      And I should see "Email: user@test.com"
      And I should see "Gender: Female"