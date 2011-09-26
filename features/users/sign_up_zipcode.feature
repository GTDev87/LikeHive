Feature: Sign up
  In order to get access to protected sections of the site
  As a user
  I want to be able to sign up with my zipcode

    Background:
      Given I am not logged in
      And I am on the home page
      And I signup
      And I fill in the following:
        | First name            | Testy McUserton |
        | Email                 | user@test.com   |
        | Password              | please          |
        | Password confirmation | please          |
      And I select "T" in "Last initial"
      And choose "Male"
      And I select date "06/27/1987" in "Date of birth"
      
    Scenario: User signs up with zipcode
      And I fill in "Zipcode" with "11210"
      And I press "Sign up"
      Then I should see "Welcome! You have signed up successfully."
      
    Scenario: User signs up wrong number of number with zipcode
      And I fill in "Zipcode" with "112101"
      And I press "Sign up"
      Then I should see "Zipcode is invalid"
      
    Scenario: User signs up zipcode with letters
      And I fill in "Zipcode" with "A1234"
      And I press "Sign up"
      Then I should see "Zipcode is invalid"
      
    Scenario: User signs up without zipcode
      And I fill in "Zipcode" with ""
      And I press "Sign up"
      Then I should see "Zipcode is invalid"
      
    Scenario: User signs up with 9-digit zipcode with dash
      And I fill in "Zipcode" with "11210-3509"
      And I press "Sign up"
      Then I should see "Welcome! You have signed up successfully"
      
    Scenario: User signs up with 9-digit zipcode
      And I fill in "Zipcode" with "112103509"
      And I press "Sign up"
      Then I should see "Welcome! You have signed up successfully"