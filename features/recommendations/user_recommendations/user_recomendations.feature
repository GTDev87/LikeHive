Feature: User Recomendations
  In order meet people like myself
  As a registered user of the website
  I want person recomendations
  
  Background:
    Given There are the following users:
    |a@test.com |
    |b@test.com |
    |c@test.com |
    |d@test.com |
    |e@test.com |
    |f@test.com |
    |g@test.com |
    |h@test.com |
    |i@test.com |
    |j@test.com |
    |k@test.com |
    |l@test.com |
    |m@test.com |
    |n@test.com |
    |o@test.com |
      
    Scenario: Seeing 5 User Recomendations
      Given I am a user with an email "greg@test.com" and password "please"
      When I sign in as "greg@test.com/please"
      And I follow "greg@test.com"
      Then I should see 5 of the following:
      |a@test.com |
      |b@test.com |
      |c@test.com |
      |d@test.com |
      |e@test.com |
      |f@test.com |
      |g@test.com |
      |h@test.com |
      |i@test.com |
      |j@test.com |
      |k@test.com |
      |l@test.com |
      |m@test.com |
      |n@test.com |
      |o@test.com |
