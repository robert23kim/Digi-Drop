Feature: Log Out

  As a user
  I want to be able to log out

Background: users have been added to database

  Given the following users exist:
  | username                | password_digest |
  | john123                 | 1234            |
  | jim234                  | 1234            |
  | mike345                 | 1234            |
  | steve456                | 1234            |
  
  And the following collectibles exist:
  | name                         | rarity               | url                                                                                                                                                   | value |
  | Kitska Warmbestrarity        | 0.001                | https://lh3.googleusercontent.com/4YPexPRmyHJ_BW_f41KKO-QdOD_vffe0ndD3tt7vu7ZCsPydNBSVy1Je-7F781SLgWP37ujmkHqhGSBUYSp4nGxKitBd6MqDlxkssg=s992         |	10    |
  | ACryptoPunk #3100            | 0.006                | https://publish.one37pm.net/wp-content/uploads/2021/02/punks.png?fit=600%2C600                                                                        | 11    |
  | Protrait of a Collector      | 0.003                | https://lh3.googleusercontent.com/tSyl3XXZmI6YI1SD3lccyyO8NOw20xxOLR0pSn-2CFqHkIRIhRnCpEaQhIIrAYdcdt0siH3AY5bY0yKldI_pkZxVNXA_HVJSUeMM=s992           | 12    |
  | F1 Delta Time                | 0.0091               | https://hackernoon.com/images/IZH5VrBxylTJuG6oTbU11LwJemA3-st7r3fy6.png                                                                               |	13    |

  And the following assets exist:
  | user_id                | collectible_id    |
  | 1                      | 1                 |
  | 1                      | 3                 |
  | 2                      | 4                 |

  And the user "john123" is logged in
  And I am on the home page
  Then 4 seed users should exist

Scenario Logout
  Given I am on the home page
  When I press "Log Out"
  Then I should be on the home page 
  And I should see "Logged Out!"
  And I should not see "My Collectibles"