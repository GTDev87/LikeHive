Feature: Like Recomendations
  In order to learn about myself
  As a registered user of the website
  I want interest recomendations

  Background:
    Given There are likes named the following:
    |fish       |
    |pizza      |
    |bread      |
    |runnning   |
    |swimming   |
    |cucumbers  |
    |happiness  |
    |sunshine   |
    |pain       |
    |fear       |
    |aggression |
    |galileo    |
    |keplar     |
    |euler      |
    |erdos      |
    |interest nobody likes|
    
    Scenario: Seeing 5 Like Recomendations
      Given I am a user with an email "greg@test.com" and password "please"
      When I sign in as "greg@test.com/please"
      And I follow "greg@test.com"
      Then I should see 5 of the following:
      |Fish       |
      |Pizza      |
      |Bread      |
      |Runnning   |
      |Swimming   |
      |Cucumbers  |
      |Happiness  |
      |Sunshine   |
      |Pain       |
      |Fear       |
      |Aggression |
      |Galileo    |
      |Keplar     |
      |Euler      |
      |Erdos      |
      |Interest Nobody Likes|
      
    Scenario: Not be recommending things already liked
      Given I am a user with an email "greg@test.com" and password "please"
      And I like the following:
      |Fish       |
      |Pizza      |
      |Bread      |
      |Runnning   |
      |Swimming   |
      |Cucumbers  |
      |Happiness  |
      |Sunshine   |
      |Pain       |
      |Fear       |
      |Aggression |
      |Galileo    |
      When I sign in as "greg@test.com/please"
      And I follow "greg@test.com"
      Then I should not be recommended:
      |Fish       |
      |Pizza      |
      |Bread      |
      |Runnning   |
      |Swimming   |
      |Cucumbers  |
      |Happiness  |
      |Sunshine   |
      |Pain       |
      |Fear       |
      |Aggression |
      |Galileo    |
      
    Scenario: Not recomendations that belong to user
      Given I am a user with an email "greg@test.com" and password "please"
      And I like the following:
      |Fish       |
      |Pizza      |
      |Bread      |
      |Runnning   |
      |Swimming   |
      |Cucumbers  |
      |Happiness  |
      |Sunshine   |
      |Pain       |
      |Fear       |
      |Aggression |
      |Galileo    |
      When I sign in as "greg@test.com/please"
      And I follow "greg@test.com"
      Then I should be recommended:
      |Keplar     |
      |Euler      |
      |Erdos      |
      |Interest Nobody Likes|
      
    Scenario: User can click recommendations
      Given I am a user with an email "greg@test.com" and password "please"
      And I like the following:
      |Fish       |
      |Pizza      |
      |Bread      |
      |Runnning   |
      |Swimming   |
      |Cucumbers  |
      |Happiness  |
      |Sunshine   |
      |Pain       |
      |Fear       |
      |Aggression |
      |Galileo    |
      When I sign in as "greg@test.com/please"
      And I follow "greg@test.com"
      And I follow "Interest Nobody Likes"
      Then I should see "Interest Nobody Likes"