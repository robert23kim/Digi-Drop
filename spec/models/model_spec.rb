# in spec/models/model_spec.rb
require 'rails_helper'

describe User do
  
  it 'should return collectibles associated with a particular user' do
    user1 = User.create! :username => 'john123'
    collectible1 = Collectible.create! :name => 'F1 Delta Time', :rarity => 0.0091, :url => 'https://hackernoon.com/images/IZH5VrBxylTJuG6oTbU11LwJemA3-st7r3fy6.png'
    asset1 = Asset.create! :user_id => "1", :collectible_id => "1"
    expect(Collectible.usersCollection(user1)).to include(collectible1)
  end

  it 'should not return collectibles not associated with a particular user' do
    user1 = User.create! :username => 'john123'
    user2 = User.create! :username => 'jim345'
    asset1 = Asset.create! :user_id => "1", :collectible_id => "1"
    collectible1 = Collectible.create! :name => 'F1 Delta Time', :rarity => 0.0091, :url => 'https://hackernoon.com/images/IZH5VrBxylTJuG6oTbU11LwJemA3-st7r3fy6.png'
    expect(Collectible.usersCollection(user2)).not_to include(collectible1)
  end

end