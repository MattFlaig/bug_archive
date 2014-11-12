require 'spec_helper'

describe SessionsController do
  describe "POST#create" do 
  	context "with valid input" do 
      let(:amanda){Fabricate(:user)}
      before{ post :create, email: amanda.email, password: amanda.password}
  	  
  	  it "puts the signed in user in the session" do 
        expect(session[:user_id]).to eq(amanda.id)
  	  end
  	  it "redirects to bugs path" do 
  	  	expect(response).to redirect_to bugs_path
  	  end
      it "sets a success message" do 
      	expect(flash[:success]).to be_present
      end
  	end

  	context "with invalid input" do 
      before do
        amanda = Fabricate(:user)
        post :create, email: amanda.email
      end

      it "does not put the user in the session" do 
        expect(session[:user_id]).to be_nil
      end
      it "sets an error message" do 
      	expect(flash[:alert]).to be_present
      end
      it "redirects to login path" do 
        expect(response).to redirect_to login_path
      end
  	end
  end

  describe "GET#destroy" do 
    before do
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end

    it "clears the user session" do 
      expect(session[:user_id]).to be_nil
    end
    it "redirects to root path" do 
      expect(response).to redirect_to root_path
    end
    it "sets the logout message" do 
      expect(flash[:success]).to be_present
    end
  end
end