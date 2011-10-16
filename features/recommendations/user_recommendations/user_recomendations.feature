Feature: User Recomendations
  In order meet people like myself
  As a registered user of the website
  I want person recomendations
  
  Background:
    Given There are the following users:
    |UserA |
    |UserB |
    |UserC |
    |UserD |
    |UserE |
    |UserF |
    |UserG |
    |UserH |
    |UserI |
    |UserJ |
    |UserK |
    |UserL |
    |UserM |
    |UserN |
    |UserO |
      
    Scenario: Seeing 5 User Recomendations
      Given I am a user with an email "greg@greg.com" and password "please"
      When I sign in as "greg@greg.com/please"
      And I follow "greg@greg.com"
      Then I should see 5 of the following:
      |UserA |
      |UserB |
      |UserC |
      |UserD |
      |UserE |
      |UserF |
      |UserG |
      |UserH |
      |UserI |
      |UserJ |
      |UserK |
      |UserL |
      |UserM |
      |UserN |
      |UserO |