Feature: User Page
  As a registered user of the website
  I want see my user profile
  so I can view my profile

    Scenario: I see my account
      Given I am a user named "foo" with an email "user@test.com" and password "please"
      When I sign in as "user@test.com/please"
      Then I should be signed in
      When I follow "foo"
      Then I should see "User: foo"
      And I should see "Email: user@test.com"