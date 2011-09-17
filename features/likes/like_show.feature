Feature: Show Like Page
  As a visitor to the website
  I want to see a like
  so I can know the site has likes


    Scenario: Viewing likes
      Given There is a like named "fish"
      When I look at the "fish" like page
      Then I should see "Fish"
      
    Scenario: Viewing multi word likes
      Given There is a like named "flying fish"
      When I look at the "flying-fish" like page
      Then I should see "Flying Fish"
      
    Scenario: Seeing users on likes page
      Given There is a user with an email "Greg@test.com" and password "OhThatGreg"
      And The user with email "Greg@test.com" likes "Pizza" 
      When I look at the "pizza" like page
      Then I should see "greg@test.com"
      
    Scenario: Seeing no users on likes page
      Given There is a like named "pizza"
      Given Nobody likes "pizza"
      When I look at the "pizza" like page
      Then I should see "No Users"