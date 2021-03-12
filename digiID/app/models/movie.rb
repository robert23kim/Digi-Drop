class Movie < ActiveRecord::Base
  def self.with_director(director_selected)
    Movie.where(director: director_selected)
  end
end
