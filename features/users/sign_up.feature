Feature: Sign up
  In order to get access to protected sections of the site
  As a user
  I want to be able to sign up

    Background:
      Given I am not logged in
      And I am on the home page
      And I go to the sign up page

    Scenario: User signs up with valid data
      And I fill in the following:
        | First name            | Testy McUserton |
        | Email                 | user@test.com   |
        | Password              | please          |
        | Password confirmation | please          |
      And I select "T" in "Last initial"
      And choose "Male"
      And I press "Sign up"
      Then I should see "Welcome! You have signed up successfully." 
    
    Scenario: User signs up without first name
      And I fill in the following:
        | First name            |                 |
        | Email                 | user@test.com   |
        | Password              | please          |
        | Password confirmation | please          |
      And I select "T" in "Last initial"
      And I press "Sign up"
      Then I should see "First name can't be blank"
      
    Scenario: User signs up with invalid email
      And I fill in the following:
        | First name            | Testy McUserton |
        | Email                 | invalidemail    |
        | Password              | please          |
        | Password confirmation | please          |
      And I select "T" in "Last initial"
      And choose "Male"
      And I press "Sign up"
      Then I should see "Email is invalid"

    Scenario: User signs up without password
      And I fill in the following:
        | First name            | Testy McUserton |
        | Email                 | user@test.com   |
        | Password              |                 |
        | Password confirmation | please          |
      And I select "T" in "Last initial"
      And choose "Male"
      And I press "Sign up"
      Then I should see "Password can't be blank"

    Scenario: User signs up without password confirmation
      And I fill in the following:
        | First name            | Testy McUserton |
        | Email                 | user@test.com   |
        | Password              | please          |
        | Password confirmation |                 |
      And I select "T" in "Last initial"
      And choose "Male"
      And I press "Sign up"
      Then I should see "Password doesn't match confirmation"

    Scenario: User signs up with mismatched password and confirmation
      And I fill in the following:
        | First name            | Testy McUserton |
        | Email                 | user@test.com   |
        | Password              | please          |
        | Password confirmation | please1         |
      And I select "T" in "Last initial"
      And choose "Male"
      And I press "Sign up"
      Then I should see "Password doesn't match confirmation"

