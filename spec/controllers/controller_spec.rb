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

describe MoviesController do
  
  describe "GET index" do
    it "assigns @movies" do
      movie = FactoryGirl.create(:movie)
      get :index
      expect(assigns(:movies)).to eq([movie])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
  
  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new movie in the database" do
        expect{
          post :create, movie: FactoryGirl.attributes_for(:movie)
        }.to change(Movie,:count).by(1)
      end
      it "redirects to the home page" do
        post :create, movie: FactoryGirl.attributes_for(:movie)
        response.should redirect_to movies_path
      end
    end
  end
  describe "GET #show" do
    it "assigns the requested movie to @movie" do
      movie = FactoryGirl.create(:movie)
      get :show, id: movie
      assigns(:movie).should eq(movie)
    end

    it "renders the #show view" do
      get :show, id: FactoryGirl.create(:movie)
      response.should render_template :show
    end
  end
  
  describe "GET others_by_same_director" do
    context "with director" do
      it "assigns the requested director to director" do
        movie = FactoryGirl.create(:movie)
        get :others_by_same_director, id: movie
        expect(assigns(:movies)).to eq([movie])
      end
    end
    context "without director" do
      it "redirects to the home page" do
        movie = FactoryGirl.create(:no_director_movie)
        get :others_by_same_director, id: movie
        response.should redirect_to root_path
      end
    end
  end
  
  describe 'PUT update' do
    before :each do
      @movie = FactoryGirl.create(:movie)
    end

    context "valid attributes" do
      it "located the requested @movie" do
        put :update, id: @movie, movie: FactoryGirl.attributes_for(:movie)
        assigns(:movie).should eq(@movie)      
      end

      it "changes @movie's attributes" do
        put :update, id: @movie, 
          movie: FactoryGirl.attributes_for(:movie, title: "Star Wars 2")
        @movie.reload
        @movie.title.should eq("Star Wars 2")
      end

      it "redirects to the updated movie" do
        put :update, id: @movie, movie: FactoryGirl.attributes_for(:movie)
        response.should redirect_to @movie
      end
    end
  end
  
  describe 'DELETE destroy' do
    before :each do
      @movie = FactoryGirl.create(:movie)
    end

    it "deletes the movie" do
      expect{
        delete :destroy, id: @movie        
      }.to change(Movie,:count).by(-1)
    end

    it "redirects to movies#index" do
      delete :destroy, id: @movie
      response.should redirect_to movies_path
    end
  end
  
  describe 'GET edit' do
    it "re-renders the edit method" do
      put :edit, id: @movie, id: FactoryGirl.create(:invalid_movie)
      response.should render_template :edit
    end
  end
  
end