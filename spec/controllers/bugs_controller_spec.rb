require 'spec_helper'

describe BugsController do 
  describe "GET#index" do 
    it_behaves_like "requires login" do 
      let(:action) {get :index}
    end

    it "sets the @bugs collection" do 
      amanda = Fabricate(:user)
      set_current_user(amanda)

      category = Fabricate(:category)
      bug1 = Fabricate(:bug, user_id: amanda.id, category_id: category.id)
      bug2 = Fabricate(:bug, user_id: amanda.id, category_id: category.id)
      get :index
      expect(Bug.all).to match_array([bug1,bug2])
    end
  end

  describe "GET#show" do
    it_behaves_like "requires login" do 
      let(:action) {get :show, id:1}
    end 

    it "sets the @bug variable" do
      amanda = Fabricate(:user)
      set_current_user(amanda)
      category = Fabricate(:category)
      bug = Fabricate(:bug, user_id: amanda.id, category_id: category.id)
      get :show, id: bug.id
      expect(assigns(:bug)).to eq(bug)
    end
  end

  describe "GET#new" do
    it_behaves_like "requires login" do 
      let(:action) {get :new}
    end  

    it "sets the @bug variable" do 
      amanda = Fabricate(:user)
      set_current_user(amanda)
      get :new
      expect(assigns(:bug)).to be_instance_of(Bug)
    end
  end

  describe "POST#create" do 
    it_behaves_like "requires login" do 
      let(:action) {post :create}
    end 

    context "with valid input" do 
    	before do 
        amanda = Fabricate(:user)
        set_current_user(amanda)
    		category = Fabricate(:category)
        post :create, bug: Fabricate.attributes_for(:bug, user_id: amanda.id, category_id: category.id)
    	end
      it "creates the bug" do 
        expect(Bug.count).to eq(1)
      end
      it "sets a flash success message" do 
 				expect(flash[:success]).to eq("New Bug created!") 
      end
      it "redirects to root path" do 
      	expect(response).to redirect_to root_path
      end
    end

    context "with invalid input" do 
    	before do 
        amanda = Fabricate(:user)
        set_current_user(amanda)
        category = Fabricate(:category)
        post :create, bug: Fabricate.attributes_for(:bug, user_id: amanda.id)
      end
    	it "does not create the bug" do 
    		expect(Bug.count).to eq(0)
    	end
    	it "renders the new template" do 
    		expect(response).to render_template(:new)
    	end
    end
  end
end