require 'rails_helper'

describe ApplicationHelper do

  describe "GET logged_in?" do
    it "returns true when user is logged in" do
      user = FactoryGirl.create(:user)
      session[:user_id] = user.id
      expect(logged_in?).to be true
    end

    it "returns false when user is not logged in" do
      session[:user_id] =  nil
      expect(logged_in?).to be false
    end
  end

  describe "GET current_user" do
    it "returns current user if the user is logged in" do
      user = FactoryGirl.create(:user)
      session[:user_id] = user.id
      expect(current_user).to eq user
    end
  end
end