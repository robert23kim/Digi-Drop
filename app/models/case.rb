class Case < ActiveRecord::Base
    has_many :contents
    has_many :collectibles, :through => :contents
end
