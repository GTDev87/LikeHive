Feature: User Signup Redirection
  As a registered user of the website
  I want to be signed in
  when i press signup

     Scenario: User signs in when signs up
      Given I am not logged in
      And I am on the home page
      And I signup
      And I sign up with the following:
        | Username              | TestMcUser      |
        | First name            | Testy McUserton |
        | Last name             | Esquire         |
        | Email                 | user@test.com   |
        | Password              | please          |
        | Password confirmation | please          |
        | Zipcode               | 11210           |
      And choose "Male"
      And I select date "06/27/1987" in "Date of birth"
      And I press "Sign up"
      Then I should see "Welcome! You have signed up successfully."
      And I should see "Profile"
      And I should see "People Recommendations"
      And I should see "Interest Recommendations"