require 'rails_helper'
# references 
# https://everydayrails.com/2012/04/07/testing-series-rspec-controllers.html

if RUBY_VERSION>='2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end

describe UsersController do

  describe "GET index" do
    it "assigns @users" do
      user = FactoryGirl.create(:user)
      get :index
      expect(assigns(:users)).to eq([user])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    it "assigns the requested user to @user" do
      user = FactoryGirl.create(:user)
      get :show, id: user
      assigns(:user).should eq(user)
    end

    it "renders the #show view" do
      get :show, id: FactoryGirl.create(:user)
      response.should render_template :show
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new user in the database" do
        #byebug
        expect{
          post :create, user: {"username" => "john123", "password" => "12345"}
        }.to change(User,:count).by(1)
      end
      it "redirects to the home page" do
        post :create, user: {"username" => "john123", "password" => "12345"}
        response.should redirect_to users_path
      end
    end
  end
  
  describe "POST #add_asset" do
    context "adds collectible as asset to user" do
      it "creates an Asset" do
        @user = FactoryGirl.create(:user)
        @prize = FactoryGirl.create(:collectible)
        #UsersController.class_variable_set :@@added_asset, nil
        #expect{post :add_asset, :id => @user.id}.to change{@@added_asset.class}.from(NilClass).to(Asset)
        post :add_asset, :id => @user.id
        assigns(:collectible_ids).should_not be_nil
        #assigns(:@@added_asset).should_not be_nil
      end
      it "redirects to the open_case page" do
      #  post :create, movie: FactoryGirl.attributes_for(:movie)
        @user = FactoryGirl.create(:user)
        @prize = FactoryGirl.create(:collectible)
        post :add_asset, :id => @user.id
        response.should redirect_to open_case_user_path
      end
    end
  end

  describe "GET #open_case" do
    context "opening a case and displaying prize" do
      it "renders the open case template" do
        @user = FactoryGirl.create(:user)
        get :open_case, :id => @user.id
        assigns(:user).should_not be_nil
        response.should render_template :open_case
      end
      it "displays prize" do     
        @user = FactoryGirl.create(:user)
        @prize = FactoryGirl.create(:collectible)
        @asset = FactoryGirl.create(:asset, :user_id => @user.id, :collectible_id => @prize.id)
        #post :add_asset, :id => @user.id
        UsersController.class_variable_set :@@added_asset, @asset
        get :open_case, :id => @user.id
        
        assigns(:user).should_not be_nil
        assigns(:added_collectible).should eq([@prize])
      end
    end
  end

  describe "GET #market" do
    it "renders the market template" do
      @user = FactoryGirl.create(:user)
      get :market, :id => @user.id
      response.should render_template :market
    end
  end
  
  describe "GET #sell" do
    before(:each) do
      request.env["HTTP_REFERER"] = "/users/1"
    end
    it "lists a collectible to the market" do
      @user = FactoryGirl.create(:user)
      @asset = FactoryGirl.create(:asset)
      expect{
        get :sell, :user_id => @user.id, :asset_id => @asset.id, :sell_price => 10.00
      }.to change(Product,:count).by(1)
    end
    it "redirects to the current page" do
      @user = FactoryGirl.create(:user)
      @asset = FactoryGirl.create(:asset)
      get :sell, :user_id => @user.id, :asset_id => @asset.id, :sell_price => 10.00
      response.should redirect_to "/users/1"
      end
  end
  
  describe "POST #unlist" do
    before do
      request.env["HTTP_REFERER"] = "/users/1"
      @user = FactoryGirl.create(:user)
      @asset = FactoryGirl.create(:asset)
      get :sell, :user_id => @user.id, :asset_id => @asset.id, :sell_price => 10.00
    end
    it "unlists a collectible to the market" do
      expect{
        post :unlist, :user_id => @user.id, :asset_id => @asset.id
      }.to change(Product,:count).by(-1)
    end
    it "redirects to the current page" do
      @user = FactoryGirl.create(:user)
      @asset = FactoryGirl.create(:asset)
      post :unlist, :user_id => @user.id, :asset_id => @asset.id
      response.should redirect_to "/users/1"
      end
  end  

  describe "POST #buy" do
    before do
      request.env["HTTP_REFERER"] = "/market/1"
      @buyer = FactoryGirl.create(:buyer)
      @buyer = FactoryGirl.create(:buyer)
      @asset = FactoryGirl.create(:asset)
      get :sell, :user_id => @user.id, :asset_id => @asset.id, :sell_price => 10.00
    end
    it "unlists a collectible to the market" do
      expect{
        post :unlist, :user_id => @user.id, :asset_id => @asset.id
      }.to change(Product,:count).by(-1)
    end
    it "redirects to the current page" do
      @user = FactoryGirl.create(:user)
      @asset = FactoryGirl.create(:asset)
      post :unlist, :user_id => @user.id, :asset_id => @asset.id
      response.should redirect_to "/market/1"
      end
  end 

end


describe SessionsController do
  describe "POST #create" do
    context "with valid attributes" do
      before :each do
        @user = FactoryGirl.create(:user)
        #post :create, 
      end
      it "saves the new user in the session" do
        post :create, :username => @user.username, :password => "12345"
        controller.session[:user_id].should eq @user.id
      end
      it "redirects to the home page if authentication is valid" do
        post :create, :username => @user.username, :password => "12345"
        response.should redirect_to users_path
      end
      it "redirects to the home page if authentication is invalid" do
        post :create, :username => @user.username, :password => "54321"
        response.should redirect_to login_path
      end
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @user = FactoryGirl.create(:user)
      delete :destroy
    end
    it "logs out of session" do
      controller.session[:user_id].should be_nil
    end
    it "redirects to movies#index" do
      response.should redirect_to users_path
    end
  end
end