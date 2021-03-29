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
  | Kitska Warmbestrarity        | C                | https://lh3.googleusercontent.com/4YPexPRmyHJ_BW_f41KKO-QdOD_vffe0ndD3tt7vu7ZCsPydNBSVy1Je-7F781SLgWP37ujmkHqhGSBUYSp4nGxKitBd6MqDlxkssg=s992         |	10    |
  | Kitska Warmbestrarity        | N                | https://lh3.googleusercontent.com/4YPexPRmyHJ_BW_f41KKO-QdOD_vffe0ndD3tt7vu7ZCsPydNBSVy1Je-7F781SLgWP37ujmkHqhGSBUYSp4nGxKitBd6MqDlxkssg=s992         |	10    |
  | Kitska Warmbestrarity        | R                | https://lh3.googleusercontent.com/4YPexPRmyHJ_BW_f41KKO-QdOD_vffe0ndD3tt7vu7ZCsPydNBSVy1Je-7F781SLgWP37ujmkHqhGSBUYSp4nGxKitBd6MqDlxkssg=s992         |	10    |
  | Kitska Warmbestrarity        | SR               | https://lh3.googleusercontent.com/4YPexPRmyHJ_BW_f41KKO-QdOD_vffe0ndD3tt7vu7ZCsPydNBSVy1Je-7F781SLgWP37ujmkHqhGSBUYSp4nGxKitBd6MqDlxkssg=s992         |	10    |
  | Chubbies #5142               | C                | https://lh3.googleusercontent.com/4YPexPRmyHJ_BW_f41KKO-QdOD_vffe0ndD3tt7vu7ZCsPydNBSVy1Je-7F781SLgWP37ujmkHqhGSBUYSp4nGxKitBd6MqDlxkssg=s992         |	10    |
  | Chubbies #5142               | N                | https://lh3.googleusercontent.com/4YPexPRmyHJ_BW_f41KKO-QdOD_vffe0ndD3tt7vu7ZCsPydNBSVy1Je-7F781SLgWP37ujmkHqhGSBUYSp4nGxKitBd6MqDlxkssg=s992         |	10    |
  | Chubbies #5142               | R                | https://lh3.googleusercontent.com/4YPexPRmyHJ_BW_f41KKO-QdOD_vffe0ndD3tt7vu7ZCsPydNBSVy1Je-7F781SLgWP37ujmkHqhGSBUYSp4nGxKitBd6MqDlxkssg=s992         |	10    |
  | Chubbies #5142               | SR               | https://lh3.googleusercontent.com/4YPexPRmyHJ_BW_f41KKO-QdOD_vffe0ndD3tt7vu7ZCsPydNBSVy1Je-7F781SLgWP37ujmkHqhGSBUYSp4nGxKitBd6MqDlxkssg=s992         |	10    |
 
  And the following cases exist:
  | name                         | url                                                                                                                                               | value
  | Featured                     | https://lh3.googleusercontent.com/TYJYbOXMZgSgG4FBju33mrHQmGvI3CnQ4A94tMZwXU5MA8scV8Pk2kUMwrdft9O5CpNitwdUO5aqZ_dJsUVlN5liwH7-0MqZfXmDlj4=s260    |	10  
  | Chubbies                     | https://lh3.googleusercontent.com/TYJYbOXMZgSgG4FBju33mrHQmGvI3CnQ4A94tMZwXU5MA8scV8Pk2kUMwrdft9O5CpNitwdUO5aqZ_dJsUVlN5liwH7-0MqZfXmDlj4=s260    |	10  

  And the following contents exist:
  | case_id                | collectible_id    |
  | 1                      | 1                 |
  | 1                      | 2                 |
  | 1                      | 3                 |
  | 1                      | 4                 |
  | 2                      | 5                 |
  | 2                      | 6                 |  
  | 2                      | 7                 |
  | 2                      | 8                 |    

Scenario: Open the featured case (default)
  Given I am on the homepage
  Given I am logged_in as "john123"
  When I follow "Cases"
  When I press "Open Case"
  Then I should see "Kitska Warmbestrarity"
  
Scenario: Select a different case, and open that instead
  Given I am on the homepage
  Given I am logged_in as "john123"
  When I follow "Cases"
  When I follow "Chubbies"
  When I press "Open Case"
  Then I should see "Chubbies #5142"