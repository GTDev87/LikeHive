Feature: Show Like
  As a visitor to the website
  I want to see a like
  so I can know the site has likes


    Scenario: Viewing likes
      Given There is a like named "Fish"
      When I look at the "fish" like page
      Then I should see "Fish"
      
    Scenario: Viewing multi word likes
      Given There is a like named "Flying Fish"
      When I look at the "flying-fish" like page
      Then I should see "Flying Fish"
      
    Scenario: Seeing users on likes page with they exits
      Given There is a user named "Greg" with an email "Greg@test.com" and password "OhThatGreg"
      And "Greg" has a like of "Pizza"
      When I look at the "pizza" like page
      Then I should see "Greg"