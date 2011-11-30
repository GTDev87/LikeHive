Feature: User Settings
  As a registered user of the website
  I want to edit my user profile
  so I can change my username

    Scenario: I sign in and edit my account, name updates
      Given I am a user with an email "user@test.com" and password "please"
      When I sign in as "user@test.com/please"
      Then I should be signed in
      When I follow "Settings"
      And I fill in "First name" with "baz"
      And I fill in "Last name" with "jones"
      And choose "Male"
      And I press "Update"
      Then I should see "User: baz jones"
      And I should see "Logged in as user@test.com"
      And I should see "Gender: Male"
      
    Scenario: Last name updates
      Given I am a user with an email "user@test.com" and password "please"
      When I sign in as "user@test.com/please"
      And I follow "Settings"
      And I fill in "First name" with "baz"
      And I fill in "Last name" with "Goodman"
      And I press "Update"
      Then I should see "User: baz Goodman"
      
    Scenario: Gender updates
      Given I am a user with an email "user@test.com" and password "please"
      When I sign in as "user@test.com/please"
      And I follow "Settings"
      And choose "Female"
      And I press "Update"
      Then I should see "Gender: Female"
      
    Scenario: Age updates
      Given the current date is "09/19/2011"
      And I am a user with an email "user@test.com" and password "please"
      When I sign in as "user@test.com/please"
      And I follow "Settings"
      And I select date "06/27/1987" in "Date of birth"
      And I press "Update"
      Then I should see "Age: 24"
      
    Scenario: Zipcode updates
      Given the current date is "09/19/2011"
      And I am a user with an email "user@test.com" and password "please"
      When I sign in as "user@test.com/please"
      And I follow "Settings"
      And I fill in "Zipcode" with "12345"
      And I select date "06/27/1987" in "Date of birth"
      And I press "Update"
      Then I should see "Zipcode: 12345"