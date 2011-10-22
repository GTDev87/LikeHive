Feature: User Signin Redirection
  As a registered user of the website
  I want to be signed in
  when i press login

    Scenario: User signs in when logs in information
      Given I am not logged in
      And I am a user with an email "user@test.com" and password "please"
      When I login
      And I sign in as "user@test.com/please"
      Then I should see "Signed in successfully."
      And I should be signed in
      And I should see "Profile"
      And I should see "People Recommendations"
      And I should see "Interest Recommendations"