class Content < ActiveRecord::Base
    belongs_to :case
    belongs_to :collectible
end