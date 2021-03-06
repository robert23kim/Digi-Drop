Feature: display balance
  As a user
  I want to be able to purchase NFTs
  So I need to see and be able to add to my balance

Background: users have been added to database

  Given the following users registered:
  | username                | password_digest | balance |
  | john123                 | 123456          | 1200.56 |
  | sam444                  | 123456          | 0.00    |
  
  And user is logged out
  
Scenario: I can see my balance while logged in
  Given I am on the homepage
  And I am logged_in as "john123"
  Then I should see "Balance: $1200.56"
  
Scenario: I don't see a balance while logged out
  Given user is logged out
  And I am on the homepage
  Then I should not see "Balance:" in any of the pages
  
Scenario: I can add funds to my balance
  Given I am on the homepage
  And I am logged_in as "sam444" with password "123456"
  Then I should see "Balance: $0.00"
  When I follow "Add Balance"
  And I fill in "Amount" with "1200.20"
  And I press "Add to Balance"
  Then  I should be on the collectibles page for "sam444"
  And I should see "Balance: $1200.20"
  
Scenario: I should start with a zero balance when I sign up
  Given user is logged out
  And I am on the homepage
  When I sign up as "six666" with password "123456"
  Then I should see "Balance: $0.00"
  
Scenario: I am returned to the Payment Method page if I accidently enter in an invalid amount
  Given I am on the homepage
  And I am logged_in as "john123"
  When I follow "Add Balance"
  And I fill in "Amount" with "-1200.20"
  And I press "Add to Balance"
  Then I should be on the payment method page for "john123"
  And I should see "Invalid input for Amount"
  And I should see "Balance: $1200.56"
  When I fill in "Amount" with "Invalid"
  And I press "Add to Balance"
  Then I should be on the payment method page for "john123"
  And I should see "Balance: $1200.56"
  
  