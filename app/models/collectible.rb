class Collectible < ActiveRecord::Base
    has_many :assets
    has_many :users, :through => :assets  
    def self.usersCollection(user)
          return self.select('*, "assets"."id" as "asset_id"').joins('INNER JOIN "assets" ON "assets"."collectible_id" = "collectibles"."id" INNER JOIN "users" ON "users"."id" = "assets"."user_id"').where("users.username = ?", user.username)
    end

end