Feature: display balance
  As a user
  I want to be able to purchase NFTs
  So I need to see and be able to add to my balance

Background: users have been added to database

  Given the following users registered:
  | username                | password_digest | balance |
  | john123                 | 123456          | 1200.56 |
  
  And user is logged out
  
Scenario: I can see my balance while logged in
  Given I am on the homepage
  And I am logged_in as "john123"
  Then I should see "Your Balance: $1200.56" in all of the pages
  
Scenario: I don't see a balance while logged out
  Given user is logged out
  And I am on the homepage
  Then I should not see "Your Balance:" in any of the pages
  
  
  
  