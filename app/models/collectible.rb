class Collectible < ActiveRecord::Base
    has_many :assets
    has_many :users, :through => :assets
end