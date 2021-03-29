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
  
  describe "POST #add" do
    context "adds collectible as asset to user" do
      it "creates an Asset" do
        @user = FactoryGirl.create(:user)
        @case = FactoryGirl.create(:case)
        @prize = FactoryGirl.create(:collectible)
        #UsersController.class_variable_set :@@added_asset, nil
        #expect{post :add_asset, :id => @user.id}.to change{@@added_asset.class}.from(NilClass).to(Asset)
        post :add, :user_id => @user.id, :case_name => @case.name
        assigns(:case_contents).should_not be_nil
        #assigns(:@@added_asset).should_not be_nil
      end
      it "redirects to the open page" do
      #  post :create, movie: FactoryGirl.attributes_for(:movie)
        @user = FactoryGirl.create(:user)
        @case = FactoryGirl.create(:case)
        @prize = FactoryGirl.create(:collectible)
        post :add, :user_id => @user.id, :case_name => @case.name
        response.should redirect_to open_path
      end
    end
  end

  describe "GET #open" do
    context "opening a case and displaying prize" do
      it "renders the open case template" do
        @user = FactoryGirl.create(:user)
        @case = FactoryGirl.create(:case)
        get :open, :user_id => @user.id
        assigns(:user).should_not be_nil
        response.should render_template :open
      end
      it "displays prize" do     
        @user = FactoryGirl.create(:user)
        @prize = FactoryGirl.create(:collectible)
        @asset = FactoryGirl.create(:asset, :user_id => @user.id, :collectible_id => @prize.id)
        #post :add_asset, :id => @user.id
        UsersController.class_variable_set :@@added_asset, @asset
        get :open, :user_id => @user.id
        
        assigns(:user).should_not be_nil
        assigns(:added_collectible).should eq([@prize])
      end
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