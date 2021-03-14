# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = [{:username => 'john123'},
    	  {:username => 'jim345'},
    	  {:username => 'mike987'},
  	 ]

users.each do |user|
  User.create!(user)
end

collectibles = [{:name => 'Kitska Warmbest', :rarity => 0.001, :url => 'https://lh3.googleusercontent.com/4YPexPRmyHJ_BW_f41KKO-QdOD_vffe0ndD3tt7vu7ZCsPydNBSVy1Je-7F781SLgWP37ujmkHqhGSBUYSp4nGxKitBd6MqDlxkssg=s992'},
				{:name => 'ATARI SNEAKER Solaris edition by Retrocoin', :rarity => 0.002, :url => 'https://storage.opensea.io/files/78c82c4f2520b8f877f8a9972247b5cd.mp4'},
				{:name => 'Protrait of a Collector', :rarity => 0.003, :url => 'https://lh3.googleusercontent.com/tSyl3XXZmI6YI1SD3lccyyO8NOw20xxOLR0pSn-2CFqHkIRIhRnCpEaQhIIrAYdcdt0siH3AY5bY0yKldI_pkZxVNXA_HVJSUeMM=s992'},
				{:name => 'Saki Ashizawa newly shot visual (Studio)', :rarity => 0.004, :url => 'https://lh3.googleusercontent.com/IjWxFQowKRGOCSot55b5pzAaA8NuZVUrt2r3N_X9cJDxVFRiHdAd_PfunuAukLrf2t84DS9ou2FTePoD9rgbwdZt9JFYXQQ1RLcHpg=s0'},
				{:name => 'Beeple NFT Sells For $69.3 Million', :rarity => 0.005, :url => 'https://specials-images.forbesimg.com/imageserve/604a301bc8447b5c819d065f/960x0.jpg?fit=scale'},
				{:name => 'CryptoPunk #3100', :rarity => 0.006, :url => 'https://publish.one37pm.net/wp-content/uploads/2021/02/punks.png?fit=600%2C600'},
				{:name => 'Nyan Cat by @nyancat', :rarity => 0.007, :url => 'https://publish.one37pm.net/wp-content/uploads/2021/02/top-NFT-sales_0006_08.jpg?fit=636%2C424'},
				{:name => 'Iniquity', :rarity => 0.008, :url => 'https://lh3.googleusercontent.com/erF1sMTRnN8gSPwzWO8aeDhJHUTFX3GxUOjQCmguF1A0K3PyBAj03qNdFZF3Rs9ryIlJzNlj-2OO4XCZAcKGHSRc=s0'},
				{:name => 'CryptoPunk #7804', :rarity => 0.009, :url => 'https://publish.one37pm.net/wp-content/uploads/2021/02/EwKNWFRXIAA94V4.png?fit=600%2C600'},
				{:name => 'F1 Delta Time', :rarity => 0.0091, :url => 'https://hackernoon.com/images/IZH5VrBxylTJuG6oTbU11LwJemA3-st7r3fy6.png'},
				{:name => 'CryptoKitty #1996756', :rarity => 0.0092, :url => 'https://opensea.io/assets/0x06012c8cf97bead5deae237070f9587f8e7a266d/1996756'},
				{:name => 'broken#boi', :rarity => 0.0093, :url => 'https://lh3.googleusercontent.com/eQqDoGXOBqz20VAeEPLTvJl8tga06leGmckY-K5_qOEdYjInNPJugtpED5ygUFvw4B3zrL-CIGj_nEZs49ScRv8jZQNOIP4J1-Vj=s0'},
  	 ]

collectibles.each do |collectible|
  Collectible.create!(collectible)
end

assets = [{:user_id => "1", :collectible_id => "2"},
    	  {:user_id => "2", :collectible_id => "4"},
    	  {:user_id => "3", :collectible_id => "6"},
  	 ]

assets.each do |asset|
  Asset.create!(asset)
end