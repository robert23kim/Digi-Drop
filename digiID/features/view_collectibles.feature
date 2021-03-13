Feature: view collectibles

  As a user
  So I can browse other users
  I want to view users' collectibles

Scenario: I view user's collectibles

  Given I am on the home page
  And I follow "View collectibles"
  Then I should see username I clicked on
  And I should see his/her collectibles