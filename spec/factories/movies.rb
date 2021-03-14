# spec/factories/movies.rb
require 'faker'
I18n.reload!

FactoryGirl.define do
  factory :user do
    username "john123"
    password_digest "12345"
  end

  factory :invalid_movie, parent: :movie do
    title nil
  end

  factory :no_director_movie, parent: :movie do
    title "Alien"
    rating "R"
    director nil
    release_date "1979-05-25"
  end
end