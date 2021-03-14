class User < ActiveRecord::Base
    has_many :assets
    has_many :collectibles, :through => :assets
end
