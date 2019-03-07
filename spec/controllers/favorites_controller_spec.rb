require 'rails_helper'

describe FavoritesController do

  before do
    @movie = Movie.create!(movie_attributes)
  end

  context "when not signed in" do

    before do
      session[:user_id] = nil
    end

    it "cannot access create" do
      post :create, params: { movie_id: @movie }

      expect(response).to redirect_to(new_session_url)
    end

    it "cannot access destroy" do
      delete :destroy, params: { id: 1, movie_id: @movie }

      expect(response).to redirect_to(new_session_url)
    end
  end
end
