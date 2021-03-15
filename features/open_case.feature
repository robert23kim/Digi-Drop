Feature: view my collectibles

  As a NFT lover
  So that I can collect my own NFTs
  I want to view my own collectibles

Background: users have been added to database

  Given the following users registered:
  | username                | password_digest |
  | john123                 | 123456          |

  And the following collectibles exist:
  | name                         | rarity               | url                                                                                                                                                   | value |
  | Kitska Warmbestrarity        | 0.001                | https://lh3.googleusercontent.com/4YPexPRmyHJ_BW_f41KKO-QdOD_vffe0ndD3tt7vu7ZCsPydNBSVy1Je-7F781SLgWP37ujmkHqhGSBUYSp4nGxKitBd6MqDlxkssg=s992         |	10    |
  

Scenario: view my collectibles
  Given I am on the homepage
  Given I am logged_in as "john123"
  When I follow "Cases"
  When I press "Open Case"
  Then I should see "Kitska Warmbestrarity"