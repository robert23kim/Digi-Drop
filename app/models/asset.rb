class Asset < ActiveRecord::Base
    belongs_to :user
    belongs_to :collectible
end