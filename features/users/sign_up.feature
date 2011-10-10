Feature: Sign up
  In order to get access to protected sections of the site
  As a user
  I want to be able to sign up

    Background:
      Given I am not logged in
      And I am on the home page
      And I signup

    Scenario: User signs up with valid data
      And I fill in the following:
        | First name            | Testy McUserton |
        | Email                 | user@test.com   |
        | Password              | please          |
        | Password confirmation | please          |
        | Zipcode               | 11210           |
      And I select "T" in "Last initial"
      And choose "Male"
      And I select date "06/27/1987" in "Date of birth"
      And I press "Sign up"
      Then I should see "Welcome! You have signed up successfully."
      When I follow "user@test.com"
      Then I should see "User: Testy McUserton T."
      And I should see "Gender: Male"
      And I should see "Email: user@test.com"
      
    Scenario: User signs up with invalid data redirects to signin page
      And I fill in the following:
        | First name            |                 |
        | Email                 | user@test.com   |
        | Password              | please          |
        | Password confirmation | please          |
        | Zipcode               | 11210           |
      And I select "T" in "Last initial"
      And choose "Male"
      And I select date "06/27/1987" in "Date of birth"
      And I press "Sign up"
      Then I should see "First name"
      And I should see "Last initial"
      And I should see "Date of birth"
      And I should see "Gender"
      And I should see "Zipcode"
      And I should see "Email"
      And I should see "Password"
      And I should see "Password confirmation"
    
    Scenario: User signs up Gender reflected
      And I fill in the following:
        | First name            | Testy McUserton |
        | Email                 | user@test.com   |
        | Password              | please          |
        | Password confirmation | please          |
        | Zipcode               | 11210           |
      And I select "T" in "Last initial"
      And choose "Female"
      And I select date "06/27/1987" in "Date of birth"
      And I press "Sign up"
      And I follow "user@test.com"
      And I should see "Gender: Female"
      
    Scenario: User signs up Last Initial reflected
      And I fill in the following:
        | First name            | Testy McUserton |
        | Email                 | user@test.com   |
        | Password              | please          |
        | Password confirmation | please          |
        | Zipcode               | 11210           |
      And I select "X" in "Last initial"
      And choose "Female"
      And I select date "06/27/1987" in "Date of birth"
      And I press "Sign up"
      And I follow "user@test.com"
      Then I should see "User: Testy McUserton X."
      
    Scenario: User signs up without age
      And I fill in the following:
        | First name            | Testy McUserton |
        | Email                 | user@test.com   |
        | Password              | please          |
        | Password confirmation | please          |
        | Zipcode               | 11210           |
      And I select "X" in "Last initial"
      And choose "Female"
      And I press "Sign up"
      Then I should see "can't be blank"
      
    Scenario: User signs up Age is reflected
      And the current date is "09/19/2011"
      And I fill in the following:
        | First name            | Testy McUserton |
        | Email                 | user@test.com   |
        | Password              | please          |
        | Password confirmation | please          |
        | Zipcode               | 11210           |
      And I select "X" in "Last initial"
      And choose "Female"
      And I select date "06/27/1987" in "Date of birth"
      And I press "Sign up"
      And I follow "user@test.com"
      Then I should see "Age: 24"
    
    Scenario: User signs up without first name
      And I fill in the following:
        | First name            |                 |
        | Email                 | user@test.com   |
        | Password              | please          |
        | Password confirmation | please          |
        | Zipcode               | 11210           |
      And I select date "06/27/1987" in "Date of birth"
      And I select "T" in "Last initial"
      And I press "Sign up"
      Then I should see "can't be blank"
      
    Scenario: User signs up with invalid email
      And I fill in the following:
        | First name            | Testy McUserton |
        | Email                 | invalidemail    |
        | Password              | please          |
        | Password confirmation | please          |
        | Zipcode               | 11210           |
      And I select "T" in "Last initial"
      And choose "Male"
      And I press "Sign up"
      Then I should see "is not formatted properly"

    Scenario: User signs up without password
      And I fill in the following:
        | First name            | Testy McUserton |
        | Email                 | user@test.com   |
        | Password              |                 |
        | Password confirmation | please          |
        | Zipcode               | 11210           |
      And I select "T" in "Last initial"
      And choose "Male"
      And I press "Sign up"
      Then I should see "can't be blank"

    Scenario: User signs up without password confirmation
      And I fill in the following:
        | First name            | Testy McUserton |
        | Email                 | user@test.com   |
        | Password              | please          |
        | Password confirmation |                 |
        | Zipcode               | 11210           |
      And I select "T" in "Last initial"
      And choose "Male"
      And I press "Sign up"
      Then I should see "doesn't match confirmation"

    Scenario: User signs up with mismatched password and confirmation
      And I fill in the following:
        | First name            | Testy McUserton |
        | Email                 | user@test.com   |
        | Password              | please          |
        | Password confirmation | please1         |
        | Zipcode               | 11210           |
      And I select "T" in "Last initial"
      And choose "Male"
      And I press "Sign up"
      Then I should see "doesn't match confirmation"

