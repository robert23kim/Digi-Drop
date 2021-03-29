# spec/factories/movies.rb
require 'faker'
I18n.reload!

FactoryGirl.define do
  factory :user do
    username "john123"
    password_digest BCrypt::Password.create("12345", cost: ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                BCrypt::Engine.cost) #"12345"
    balance 123.00
  end
  factory :collectible do
    name "Kitska Warmbestrarity"
    rarity 0.001
    url "https://lh3.googleusercontent.com/4YPexPRmyHJ_BW_f41KKO-QdOD_vffe0ndD3tt7vu7ZCsPydNBSVy1Je-7F781SLgWP37ujmkHqhGSBUYSp4nGxKitBd6MqDlxkssg=s992"
    value 10
  end
  factory :asset do
    user_id "1" 
    collectible_id "1"
  end
  factory :product do
    user_id "1" 
    asset_id "1"
    sell_price "100"
  end
end