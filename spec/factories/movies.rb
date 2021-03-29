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
    rarity ''
    url "https://lh3.googleusercontent.com/4YPexPRmyHJ_BW_f41KKO-QdOD_vffe0ndD3tt7vu7ZCsPydNBSVy1Je-7F781SLgWP37ujmkHqhGSBUYSp4nGxKitBd6MqDlxkssg=s992"
    value 10
  end
  factory :asset do
    user_id "1" 
    collectible_id "1"
  end
  factory :case do
    name 'Featured'
    url 'https://lh3.googleusercontent.com/WI5xTAibboR86Q6gH7BVrar38WMMYYlbZsp7SOpBvMwYTN6Gcehh24Eitjg5she-KFzRyUCAUvl58Cpg0_KHZpNLfVNokXk4NlFG1xc=w326'
    value 10.00
  end
end