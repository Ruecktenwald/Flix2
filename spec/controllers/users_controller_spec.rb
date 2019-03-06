require 'rails_helper'

describe UsersController do

  before do
    @user = User.create!(user_attributes)
  end

  context "when not signed in" do

    before do
      session[:user_id] = nil
    end

    it "cannot access index" do
      get :index

      expect(response).to redirect_to(new_session_url)
    end

    it "cannot access show" do
      get :show, params: { id: @user }

      expect(response).to redirect_to(new_session_url)
    end

    it "cannot access edit" do
      get :edit, params: { id: @user }

      expect(response).to redirect_to(new_session_url)
    end

    it "cannot access update" do
      patch :update, params: { id: @user }

      expect(response).to redirect_to(new_session_url)
    end

    it "cannot access destroy" do
      delete :destroy, params: { id: @user }

      expect(response).to redirect_to(new_session_url)
    end
  end

  context "when signed in as the wrong user" do
    
    before do
      @wrong_user = User.create!(user_attributes(email: "wrong@example.com"))
      session[:user_id] = @wrong_user.id
    end
    
    it "cannot edit another user" do
      get :edit, params: { id: @user }
      
      expect(response).to redirect_to(root_url)
    end
    
    it "cannot update another user" do
      patch :update, params: { id: @user }
      
      expect(response).to redirect_to(root_url)
    end
    
    it "cannot destroy another user" do
      delete :destroy, params: { id: @user }
      
      expect(response).to redirect_to(root_url)
    end
    
  end
  
end
