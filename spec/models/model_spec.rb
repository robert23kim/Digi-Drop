# in spec/models/model_spec.rb
require 'rails_helper'

describe User do
  
  it 'should return collectibles associated with a particular user' do
    user1 = User.create! :username => 'john123', :password_digest => '12345'
    collectible1 = Collectible.create! :name => 'F1 Delta Time', :rarity => 0.0091, :url => 'https://hackernoon.com/images/IZH5VrBxylTJuG6oTbU11LwJemA3-st7r3fy6.png'
    asset1 = Asset.create! :user_id => "1", :collectible_id => "1"
    expect(Collectible.usersCollection(user1)).to include(collectible1)
  end

  it 'should not return collectibles not associated with a particular user' do
    user1 = User.create! :username => 'john123', :password_digest => '12345'
    user2 = User.create! :username => 'jim345', :password_digest => '12345'
    asset1 = Asset.create! :user_id => "1", :collectible_id => "1"
    collectible1 = Collectible.create! :name => 'F1 Delta Time', :rarity => 0.0091, :url => 'https://hackernoon.com/images/IZH5VrBxylTJuG6oTbU11LwJemA3-st7r3fy6.png'
    expect(Collectible.usersCollection(user2)).not_to include(collectible1)
  end
  
  context "converting float balance to string" do
    it "converts 0.0 to $0.00" do
      user = FactoryGirl.create(:user, :balance => 0.0)
      expect(User.balanceToString(user)).to eq("$0.00")
    end
    it "converts nil to $0.00" do
      user = FactoryGirl.create(:user, :balance => nil)
      expect(User.balanceToString(user)).to eq("$0.00")
    end
    it "converts int to money format" do
      user = FactoryGirl.create(:user, :balance => 12)
      expect(User.balanceToString(user)).to eq("$12.00")
    end
    it "converts 0.6 to $0.60" do
      user = FactoryGirl.create(:user, :balance => 0.6)
      expect(User.balanceToString(user)).to eq("$0.60")
    end
    it "converts 64.56 to $64.56" do
      user = FactoryGirl.create(:user, :balance => 64.56)
      expect(User.balanceToString(user)).to eq("$64.56")
    end
    it "converts 64.5622 to $64.56" do
      user = FactoryGirl.create(:user, :balance => 64.5622)
      expect(User.balanceToString(user)).to eq("$64.56")
    end
    
  end

end