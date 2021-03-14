Feature: view collectibles

  As a user
  So I can browse other users
  I want to view users' collectibles
  
Background: users have been added to database

  Given the following users exist:
  | username                |
  | john123                 |
  | jim234                  |
  | mike345                 |
  | steve456                |

  And I am on the home page
  Then 4 seed users should exist

Scenario: I view user's collectibles

  Given I am on the home page
  When I follow "john123"
  Then I should see john123 collectibles