Feature: sign up and log in

  As a NFT lover
  So that I can collect my own NFTs
  I want to sign up or log in for DigiID

Background: users have been added to database

  Given the following users registered:
  | username                | password_digest |
  | john123                 | 123456          |

  Given user is logged out

Scenario: sign up for a new account
  Given I am on the homepage
  When I follow "Sign Up"
  Then I should be on the signup page
  And I should see "Username"
  And I should see "Password"
  When I fill in "Username" with a nonexistent user
  When I fill in "Password" with "123456"
  And I press "Create Account"
  Then I should be on the homepage

Scenario: sign up using an existent user
  Given I am on the homepage
  When I follow "Sign Up"
  Then I should be on the signup page
  And I should see "Username"
  And I should see "Password"
  When I fill in "Username" with "john123"
  When I fill in "Password" with "123456"
  And I press "Create Account"
  And I should see "Username alreay exists"

Scenario: log in successfully
  Given I am on the homepage
  When I follow "Log In"
  Then I should be on the login page
  And I should see "Username"
  And I should see "Password"
  When I fill in "Username" with "john123"
  When I fill in "Password" with "123456"
  And I press "Login"
  Then I should be on the homepage
  And I should see "My Collectibles"
  

Scenario: log in with wrong password
  Given I am on the homepage
  When I follow "Log In"
  Then I should be on the login page
  And I should see "Username"
  And I should see "Password"
  When I fill in "Username" with "john123"
  When I fill in "Password" with "wrong"
  And I press "Login"
  Then I should see "Username or password is invalid"

Scenario: log out
  Given I am on the homepage
  Given I am logged_in as "john123"
  When I follow "Log Out"
  And I should see "Logged out!"
