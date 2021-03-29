# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Returns the hash digest of the given string.
def password_digest(string)
  cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                BCrypt::Engine.cost
  BCrypt::Password.create(string, cost: cost)
end

users = [{:username => 'john123', :password_digest => "#{password_digest('123456')}"},
    	  {:username => 'jim345', :password_digest => "#{password_digest('123456')}"},
    	  {:username => 'mike987', :password_digest => "#{password_digest('123456')}"},
  	 ]

users.each do |user|
  User.create!(user)
end

collectibles = [
                # general, 1-10
                {:name => 'Kitska Warmbest', :rarity => 'C', :url => 'https://lh3.googleusercontent.com/4YPexPRmyHJ_BW_f41KKO-QdOD_vffe0ndD3tt7vu7ZCsPydNBSVy1Je-7F781SLgWP37ujmkHqhGSBUYSp4nGxKitBd6MqDlxkssg=s992', :value => 10.00},
				{:name => 'Protrait of a Collector', :rarity => 'C', :url => 'https://lh3.googleusercontent.com/tSyl3XXZmI6YI1SD3lccyyO8NOw20xxOLR0pSn-2CFqHkIRIhRnCpEaQhIIrAYdcdt0siH3AY5bY0yKldI_pkZxVNXA_HVJSUeMM=s992', :value => 75.00},
				{:name => 'Saki Ashizawa newly shot visual', :rarity => 'C', :url => 'https://lh3.googleusercontent.com/IjWxFQowKRGOCSot55b5pzAaA8NuZVUrt2r3N_X9cJDxVFRiHdAd_PfunuAukLrf2t84DS9ou2FTePoD9rgbwdZt9JFYXQQ1RLcHpg=s0', :value => 157.00},
				{:name => 'Beeple NFT Sells For $69.3 Million', :rarity => 'N', :url => 'https://specials-images.forbesimg.com/imageserve/604a301bc8447b5c819d065f/960x0.jpg?fit=scale', :value => 335.00},
				{:name => 'CryptoPunk #3100', :rarity => 'N', :url => 'https://publish.one37pm.net/wp-content/uploads/2021/02/punks.png?fit=600%2C600', :value => 689.00},
				{:name => 'Nyan Cat by @nyancat', :rarity => 'N', :url => 'https://publish.one37pm.net/wp-content/uploads/2021/02/top-NFT-sales_0006_08.jpg?fit=636%2C424', :value => 12384.00},
				{:name => 'Iniquity', :rarity => 'N', :url => 'https://lh3.googleusercontent.com/erF1sMTRnN8gSPwzWO8aeDhJHUTFX3GxUOjQCmguF1A0K3PyBAj03qNdFZF3Rs9ryIlJzNlj-2OO4XCZAcKGHSRc=s0', :value => 15000.00},
				{:name => 'CryptoPunk #7804', :rarity => 'R', :url => 'https://publish.one37pm.net/wp-content/uploads/2021/02/EwKNWFRXIAA94V4.png?fit=600%2C600', :value => 23789.00},
				{:name => 'F1 Delta Time', :rarity => 'R', :url => 'https://hackernoon.com/images/IZH5VrBxylTJuG6oTbU11LwJemA3-st7r3fy6.png', :value => 108000.00},
				{:name => 'broken#boi', :rarity => 'SR', :url => 'https://lh3.googleusercontent.com/eQqDoGXOBqz20VAeEPLTvJl8tga06leGmckY-K5_qOEdYjInNPJugtpED5ygUFvw4B3zrL-CIGj_nEZs49ScRv8jZQNOIP4J1-Vj=s0', :value => 1000000.00},
    
                # Chubbies, 11-16
                {:name => 'Chubbies #2527', :rarity => 'C', :url => 'https://lh3.googleusercontent.com/8kHH4TG5lT1cOfKhBIToJhF2lwG-3jleEuJb1HddLNyODpLhHojqIsClCvcfemAgwUgqJKEKTT9DA-BDVoaSPrXFPwE8HzVwgGq5Bw=s992', :value => 20.00},
				{:name => 'Chubbies #8940', :rarity => 'C', :url => 'https://lh3.googleusercontent.com/B-9D6zLCM2EkhvjwTRDNAVeJt5aS0GypKqMlMGVt_vVq9FtMKZSJsBKEtLFF1CowX-PP0hde33-Ddb3HeUMlu_yvJ6t8rzEFAHXNBw=s992', :value => 40.00},
				{:name => 'Chubbies #2213', :rarity => 'N', :url => 'https://lh3.googleusercontent.com/WhJD1YOqiPQGNiw8Vi1R-zvPIc4wxf99r8UHwn8XYodyk84c3vUJwwy--f4HEQUhmuCxhMHsyqz7pt6jdhOmFRmljp-yb9uHRWAeYg=s992', :value => 400.00},
				{:name => 'Chubbies #6535', :rarity => 'N', :url => 'https://lh3.googleusercontent.com/nsFXaHAZzBbtqc4ud8xO1dHpS1EN6puoek3P0YJTyFe4pj43Jq7cz-LqskI5HBCZrnMBJoV2URqEz0YMYur_IOOKWu8-jQr3aaz2fIs=s992', :value => 700.00},
				{:name => 'Chubbies #5142', :rarity => 'R', :url => 'https://lh3.googleusercontent.com/u7GsI2B5B1KFqd7dUDzbhmlyZP35aGopWp9fxzhrUFqW0Wro3xgkDJ9H-EVct7TpPCHkh7VxkJeCw3vzV4retxdzYeYSR1nLO4Ck=s992', :value => 10000.00},
                {:name => 'Chubbies #2211', :rarity => 'SR', :url => 'https://lh3.googleusercontent.com/hgpkJgHzslBmztgsinIBa_iZkJYMGaR8jxCMrb_5c2lR0ZMQjB24KVpvFoBbcVM5IDJCXB0hDRhDbMC8rbsaIoEk9ksjH2FWf1EGFg=s992', :value => 70000.00},
    
                # infectedpokemon, 17-26
                {:name => 'Infected Charmeleon', :rarity => 'C', :url => 'https://lh3.googleusercontent.com/DJeAv3ajY9GRoPde9PuZ029nXp020XvDNNx-K-zYPoM7G_wpCbf6QcuKrERRBKhSbGaGRy_Wf88Jb1OeuPzbRdnorr9zdf8tWFt6XNM=s992', :value => 30.00},
				{:name => 'Infected Ivysaur', :rarity => 'C', :url => 'https://lh3.googleusercontent.com/OuDqyBUjd6JCLnf-uPOl93QN1KeYqIj1Xuvrhh-C2I-bb4vgG2ItjcPYDxx9iigfYtCw_CwNV4jit8-zVuADtbsBFpsqiXn0WA3cCn4=s992', :value => 24.00},
                {:name => 'Infected Wartortle', :rarity => 'C', :url => 'https://lh3.googleusercontent.com/0ZyU_jhHc1Y73a1z0IhqhxKS-6PYjAJWjZp7fkBuS-jUVGKzX7O1ly81Q1alnc61DhPqNqzE-MgDjqzCytaUdwDdLITwGiaZYIqEXw=s992', :value => 33.00},
				{:name => 'Infected Charizard', :rarity => 'N', :url => 'https://lh3.googleusercontent.com/JerQF4mvlHe18xsfbEiw3wNNBa1IkJbAXZ8-W8RqsVtewCHjkufyfa7ZC0C_4UnW9j_nhlitIX5QAE3-1xdcRTmpWQ6hX5cutWbO-w=s992', :value => 7500.00},
				{:name => 'Infected Venusaur', :rarity => 'N', :url => 'https://lh3.googleusercontent.com/j18ynLPG9jYiyQ3UBwrskSu0smK3rELKfx5t2VHAmBE2FLCzGbPpCAtKlAFjOqBhXhKRPI7M5HffUZfKI6RmDmSm6OIIychVbSBC4ck=s992', :value => 4400.00},
                {:name => 'Infected Blastoise', :rarity => 'N', :url => 'https://lh3.googleusercontent.com/weK46FIzml-K1Vgi8YoWilGXCmq6O3MhhMBfr7kihuwwrhbWPLWv8Kx2IdmSEeYedGAQrH1s5BVecTAv6u-7WHxaToDjcQzsgsq0wUM=s992', :value => 8800.00},
                {:name => 'Infected Charmander', :rarity => 'R', :url => 'https://lh3.googleusercontent.com/KJT4MiVQAg_7YTO1vnNRUcx4bOBecWQYCcYpQgTH4rkD-EX1aHEUXtJpefg6Ca85NBQnbLhs4jX3S_Ii-tVDFUHTj2o-TKMp3t5OtC8=s992', :value => 20000.00},
				{:name => 'Infected Bulbasaur', :rarity => 'R', :url => 'https://lh3.googleusercontent.com/Pn8MHlOxUCBkWph5jVZDII9tolaIAnrTX_6wvYC6rHQzxiikk2_v6lbbfFtqAJelFHTAEh3LQeW46uGGHtHIAI7BS3aS0YYidg8T=s992', :value => 17000.00},
                {:name => 'Infected Squirtle', :rarity => 'R', :url => 'https://lh3.googleusercontent.com/LKJ8xl_DTTV-KEdJVp8QenRNJ7x1gFYgLOm2OVWfCmMSgSh8SzsYHntoCTcx6tNfPH9DlbRaG--ImdV-jUU0xOoF_q4bWlOThRSB=s992', :value => 10000.00},
                {:name => 'Infected Pikachu', :rarity => 'SR', :url => 'https://lh3.googleusercontent.com/_-7y7q5e2yXy3TMIezvIikSWwUc2JTUUUfmUDvfyDe4YmrZVXOF9u1J9g3YbVAqNJJkI9phM_n3myRo5w4Rr47Kmqf5gGm9jC5dbxeA=s992', :value => 70000.00},
  	 ]

collectibles.each do |collectible|
  Collectible.create!(collectible)
end

assets = [{:user_id => 1, :collectible_id => 1},
		  {:user_id => 1, :collectible_id => 3},
    	  {:user_id => 2, :collectible_id => 4},
    	  {:user_id => 3, :collectible_id => 6},
  	 ]

assets.each do |asset|
  Asset.create!(asset)
end

cases = [
    {:name => 'Featured', :url => 'https://lh3.googleusercontent.com/TYJYbOXMZgSgG4FBju33mrHQmGvI3CnQ4A94tMZwXU5MA8scV8Pk2kUMwrdft9O5CpNitwdUO5aqZ_dJsUVlN5liwH7-0MqZfXmDlj4=s260', :value => 10.00},
    {:name => 'Chubbies', :url => 'https://lh3.googleusercontent.com/C6MjLotA2if8-9KjAJmTnM0TSTU6-eMm10t0pvNygWMoSDNmeI74Xy0Einl5CQ4LRGOHrOvk0RBd8JR0Eb25vc8kQPkFSQbUvlw8dQ=w326', :value => 10.00},
    {:name => 'infectedpokemon', :url => 'https://lh3.googleusercontent.com/WI5xTAibboR86Q6gH7BVrar38WMMYYlbZsp7SOpBvMwYTN6Gcehh24Eitjg5she-KFzRyUCAUvl58Cpg0_KHZpNLfVNokXk4NlFG1xc=w326', :value => 10.00},
  	 ]

cases.each do |col_case|
  Case.create!(col_case)
end

contents = [
        {:case_id => 1, :collectible_id => 1},
        {:case_id => 1, :collectible_id => 2},
        {:case_id => 1, :collectible_id => 3},
        {:case_id => 1, :collectible_id => 4},
        {:case_id => 1, :collectible_id => 5},
        {:case_id => 1, :collectible_id => 6},
        {:case_id => 1, :collectible_id => 7},
        {:case_id => 1, :collectible_id => 8},
        {:case_id => 1, :collectible_id => 9},
        {:case_id => 1, :collectible_id => 10},
        {:case_id => 2, :collectible_id => 11},
        {:case_id => 2, :collectible_id => 12},
        {:case_id => 2, :collectible_id => 13},
        {:case_id => 2, :collectible_id => 14},
        {:case_id => 2, :collectible_id => 15},
        {:case_id => 2, :collectible_id => 16},
        {:case_id => 3, :collectible_id => 17},
        {:case_id => 3, :collectible_id => 18},
        {:case_id => 3, :collectible_id => 19},
        {:case_id => 3, :collectible_id => 20},
        {:case_id => 3, :collectible_id => 21},
        {:case_id => 3, :collectible_id => 22},
        {:case_id => 3, :collectible_id => 23},
        {:case_id => 3, :collectible_id => 24},
        {:case_id => 3, :collectible_id => 25},
        {:case_id => 3, :collectible_id => 26},
  	 ]

contents.each do |content|
  Content.create!(content)
end