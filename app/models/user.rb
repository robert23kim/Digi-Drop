class User < ActiveRecord::Base
    has_many :assets
    has_many :collectibles, :through => :assets
    has_secure_password
end
