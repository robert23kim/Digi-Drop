class Product < ActiveRecord::Base
  def self.products()
    return self.select('*, "assets"."user_id" as "user_id", "Assets"."id" as "asset_id"').joins('INNER JOIN "assets" ON "assets"."id" = "products"."asset_id" INNER JOIN "collectibles" ON "collectibles"."id" = "assets"."collectible_id"')
  end
end