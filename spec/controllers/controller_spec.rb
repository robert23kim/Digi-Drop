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
          post :create, user: FactoryGirl.attributes_for(:user)
        }.to change(User,:count).by(1)
      end
      it "redirects to the home page" do
        post :create, user: FactoryGirl.attributes_for(:user)
        response.should redirect_to users_path
      end
    end
  end
  
  describe "POST #add_asset" do
    context "adds collectible as asset to user" do
      it "creates an Asset" do
      #  expect{
      #    post :create, movie: FactoryGirl.attributes_for(:movie)
      #  }.to change(Movie,:count).by(1)
        @user = FactoryGirl.create(:user)
        @prize = FactoryGirl.create(:collectible)
        post :add_asset, :id => @user.id
        assigns(:collectible_ids).should_not be_nil
        assigns(:added_asset).should_not be_nil
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
        #byebug
        #post :create, movie: FactoryGirl.attributes_for(:movie)
        #response.should redirect_to movies_path
        
        @user = FactoryGirl.create(:user)
        @prize = FactoryGirl.create(:collectible)
        post :add_asset, :id => @user.id
        #get :open_case, :id => @user.id
        assigns(:user).should_not be_nil
        assigns(:added_collectible).should_not be_nil
      end
    end
  end

  
end


describe SessionsController do
  describe "POST #create" do
    context "with valid attributes" do
    #  before :each do
    #    @user = FactoryGirl.create(:user)
    #      post :create, user: FactoryGirl.attributes_for(:user)
    #  end
    #  it "saves the new user in the session" do
    #    controller.session[:user_id].should eq @user.id
    #  end
    #  it "redirects to the home page" do  
    #    response.should redirect_to users_path
    #  end
    end
  end

  describe 'DELETE destroy' do
    #before :each do
    #  @movie = FactoryGirl.create(:movie)
    #enduser
    #  delete :destroy, id: @user

    #it "deletes the movie" do
    #  exlogs out of session
    #  controller.session[:user_id].should be_nil

    #it "redirects to movies#index" do
    #  delete :destroyusers@movie movies_path
    #endusers
  end
end