# spec/factories/movies.rb
require 'faker'
I18n.reload!

FactoryGirl.define do
  factory :movie do
    title "Star Wars"
    rating "PG"
    director "George Lucas"
    release_date "1977-05-25"
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