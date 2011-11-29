Feature: Sign up
  In order to get access to protected sections of the site
  As a user
  I want to be able to sign up

    Background:
      Given I am not logged in
      And I am on the home page
      And I signup

    Scenario: User signs up with valid data
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
      And I should see "Username: TestMcUser"
      And I should see "User: Testy McUserton Esquire"
      And I should see "Gender: Male"
      And I should see "Logged in as user@test.com"
      
    Scenario: User signs up with invalid data redirects to signin page
      And I sign up with the following:
        | Username              | TestMcUser      |
        | First name            |                 |
        | Last name             | Esquire         |
        | Email                 | user@test.com   |
        | Password              | please          |
        | Password confirmation | please          |
        | Zipcode               | 11210           |
      And choose "Male"
      And I select date "06/27/1987" in "Date of birth"
      And I press "Sign up"
      Then I should see "First name"
      And I should see "Last name"
      And I should see "Date of birth"
      And I should see "Gender"
      And I should see "Zipcode"
      And I should see "Email"
      And I should see "Password"
      And I should see "Password confirmation"
    
    Scenario: User signs up Gender reflected
      And I sign up with the following:
        | Username              | TestMcUser      |
        | First name            | Testy McUserton |
        | Last name             | Esquire         |
        | Email                 | user@test.com   |
        | Password              | please          |
        | Password confirmation | please          |
        | Zipcode               | 11210           |
      And choose "Female"
      And I select date "06/27/1987" in "Date of birth"
      And I press "Sign up"
      And I should see "Gender: Female"
      
    Scenario: User signs up Last Initial reflected
      And I sign up with the following:
        | Username              | TestMcUser      |
        | First name            | Testy McUserton |
        | Last name             | Jones           |
        | Email                 | user@test.com   |
        | Password              | please          |
        | Password confirmation | please          |
        | Zipcode               | 11210           |
      And choose "Female"
      And I select date "06/27/1987" in "Date of birth"
      And I press "Sign up"
      Then I should see "User: Testy McUserton Jones"
      
    Scenario: User signs up without age
      And I sign up with the following:
        | Username              | TestMcUser      |
        | First name            | Testy McUserton |
        | Last name             | Esquire         |
        | Email                 | user@test.com   |
        | Password              | please          |
        | Password confirmation | please          |
        | Zipcode               | 11210           |
      And choose "Female"
      And I press "Sign up"
      Then I should see "can't be blank"
      
    Scenario: User signs up Age is reflected
      And the current date is "09/19/2011"
      And I sign up with the following:
        | Username              | TestMcUser      |
        | First name            | Testy McUserton |
        | Last name             | Esquire         |
        | Email                 | user@test.com   |
        | Password              | please          |
        | Password confirmation | please          |
        | Zipcode               | 11210           |
      And choose "Female"
      And I select date "06/27/1987" in "Date of birth"
      And I press "Sign up"
      Then I should see "Age: 24"
    
    Scenario: User signs up without username
      And I sign up with the following:
        | Username              |                 |
        | First name            | Testy McUserton |
        | Last name             | Esquire         |
        | Email                 | user@test.com   |
        | Password              | please          |
        | Password confirmation | please          |
        | Zipcode               | 11210           |
      And I select date "06/27/1987" in "Date of birth"
      And I press "Sign up"
      Then I should see "can't be blank"
    
    Scenario: User signs up without first name
      And I sign up with the following:
        | Username              | TestMcUser      |
        | First name            |                 |
        | Last name             | Esquire         |
        | Email                 | user@test.com   |
        | Password              | please          |
        | Password confirmation | please          |
        | Zipcode               | 11210           |
      And I select date "06/27/1987" in "Date of birth"
      And I press "Sign up"
      Then I should see "can't be blank"
      
    Scenario: User signs up with invalid email
      And I sign up with the following:
        | Username              | TestMcUser      |
        | First name            | Testy McUserton |
        | Last name             | Esquire         |
        | Email                 | invalidemail    |
        | Password              | please          |
        | Password confirmation | please          |
        | Zipcode               | 11210           |
      And choose "Male"
      And I press "Sign up"
      Then I should see "is not formatted properly"

    Scenario: User signs up without password
      And I sign up with the following:
        | Username              | TestMcUser      |
        | First name            | Testy McUserton |
        | Last name             | Esquire         |
        | Email                 | user@test.com   |
        | Password              |                 |
        | Password confirmation | please          |
        | Zipcode               | 11210           |
      And choose "Male"
      And I press "Sign up"
      Then I should see "doesn't match confirmation"

    Scenario: User signs up without password confirmation
      And I sign up with the following:
        | Username              | TestMcUser      |
        | First name            | Testy McUserton |
        | Last name             | Esquire         |
        | Email                 | user@test.com   |
        | Password              | please          |
        | Password confirmation |                 |
        | Zipcode               | 11210           |
      And choose "Male"
      And I press "Sign up"
      Then I should see "doesn't match confirmation"

    Scenario: User signs up with mismatched password and confirmation
      And I sign up with the following:
        | Username              | TestMcUser      |
        | First name            | Testy McUserton |
        | Last name             | Esquire         |
        | Email                 | user@test.com   |
        | Password              | please          |
        | Password confirmation | please1         |
        | Zipcode               | 11210           |
      And choose "Male"
      And I press "Sign up"
      Then I should see "doesn't match confirmation"

