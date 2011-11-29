Feature: User Profile Page
  As a registered user of the website
  I want see my user profile
  so I can view my profile
    
    Scenario: I see my account
      Given I am a user with an email "greg@test.com" and password "please"
      And I have first name "Greg" and last name "Thompson"
      When I sign in as "greg@test.com/please"
      And I follow "Profile"
      Then I should see "Profile:"
      And I should see "User:"
      And I should see "Gender:"      
      
    Scenario: I see my username
      Given I am a user with an email "greg@test.com" and password "please"
      And I have first name "Greg" and last name "Thompson"
      And I have the username "GregT87"
      When I sign in as "greg@test.com/please"
      Then I should see "Username: GregT87"
    
    Scenario: I see myself logged in
      Given I am a user with an email "greg@test.com" and password "please"
      And I have first name "Greg" and last name "Thompson"
      When I sign in as "greg@test.com/please"
      Then I should be signed in
      And I should see "Logged in as greg@test.com"
      
    Scenario: I see my email on my page
      Given I am a user with an email "greg@test.com" and password "please"
      And I have first name "Greg" and last name "Thompson"
      When I sign in as "greg@test.com/please"
      Then I should see "Logged in as greg@test.com"
      
    Scenario: Displays Gender Correctly
      Given I am a user with an email "greg@test.com" and password "please"
      And my gender is "Female"
      When I sign in as "greg@test.com/please"
      Then I should be signed in
      Then I should see "Gender: Female"
      
    Scenario: Displays Name Correctly
      Given I am a user with an email "greg@test.com" and password "please"
      And I have first name "Greg" and last name "Thompson"
      When I sign in as "greg@test.com/please"
      Then I should be signed in
      Then I should see "User: Greg Thompson"
      
    Scenario: Displays Age Correctly
      Given the current date is "09/19/2011"
      And I am a user with an email "greg@test.com" and password "please"
      And my date of birth is "1987/06/27"
      When I sign in as "greg@test.com/please"
      Then I should see "Age: 24"
      
    Scenario: Displays Zipcode Correctly
      Given the current date is "09/19/2011"
      And I am a user with an email "greg@test.com" and password "please"
      And my zipcode is "11210"
      When I sign in as "greg@test.com/please"
      Then I should see "Zipcode: 11210"
      