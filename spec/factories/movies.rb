# spec/factories/movies.rb
require 'faker'
I18n.reload!

FactoryGirl.define do
  factory :user do
    username "john123"
    password_digest "12345"
  end
end