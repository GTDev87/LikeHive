Feature: User Authentication
  As a registered user of the website
  I want my user's sessions separate
  so my data is private to myself
    
    Background:
      Given There is a user with an email "zac@test.com" and password "please"
      And the email "zac@test.com" has the user name "Zac"
    
    Scenario: I can't see others account when not logged in     
      When I visit the "profile" page
      Then I should see "Access Denied"
      
    Scenario:I can't edit others account when not logged in 
      When I navigate to the user "profile/edit" page
      Then I should see "Access Denied"