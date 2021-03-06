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
  | ACryptoPunk #3100            | C                | https://publish.one37pm.net/wp-content/uploads/2021/02/punks.png?fit=600%2C600                                                                        | 11    |
  | Protrait of a Collector      | C               | https://lh3.googleusercontent.com/tSyl3XXZmI6YI1SD3lccyyO8NOw20xxOLR0pSn-2CFqHkIRIhRnCpEaQhIIrAYdcdt0siH3AY5bY0yKldI_pkZxVNXA_HVJSUeMM=s992           | 12    |
  | F1 Delta Time                | C               | https://hackernoon.com/images/IZH5VrBxylTJuG6oTbU11LwJemA3-st7r3fy6.png                                                                               |	13    |

  And the following assets exist:
  | user_id                | collectible_id    |
  | 1                      | 1                 |
  | 1                      | 3                 |
  | 2                      | 4                 |

Scenario: view my collectibles
  Given I am on the homepage
  Given I am logged_in as "john123"
  When I follow "Manage"
  Then  I should be on the collectibles page for "john123"
  And   I should see "Kitska Warmbestrarity"
  And   I should see "Protrait of a Collector"
