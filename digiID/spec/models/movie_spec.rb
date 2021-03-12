# in spec/models/movie_spec.rb
require 'rails_helper'

describe Movie do
  
  it 'should return the correct matches for movies by the same director' do
    movie1 = Movie.create! :title => 'Star Wars', :director => 'John Doe'
    expect(Movie.with_director('John Doe')).to include(movie1)
  end

  it 'should not return matches of movies by different directors' do
    movie1 = Movie.create! :title => 'Star Wars', :director => 'John Doe'
    expect(Movie.with_director('Not John Doe')).not_to include(movie1)
  end

end