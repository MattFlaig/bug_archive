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

  describe "PUT#update" do 
    it_behaves_like "requires login" do 
      let(:action) {put :update, id: 1}
    end

    context "with valid input" do 
      let (:category) {Fabricate(:category)}
      let (:amanda) {Fabricate(:user)}
      let (:bug) {Fabricate(:bug, user_id: amanda.id, category_id: category.id)} 
      
      before do 
        set_current_user(amanda)
        put :update, {id: bug.id, bug: { name: "updated bug" } }
      end

      it "updates the bug" do 
        expect(Bug.first.name).to eq("updated bug")
      end
      it "sets a success message" do 
        expect(flash[:success]).to be_present
      end
      it "redirects to bug show" do 
        expect(response).to redirect_to bug_path(bug.id)
      end
    end

    context "with invalid input" do 
      let (:category) {Fabricate(:category)}
      let (:amanda) {Fabricate(:user)}
      let (:bug) {Fabricate(:bug, user_id: amanda.id, category_id: category.id)} 
      
      before do 
        set_current_user(amanda)
        put :update, {id: bug.id, bug: {name: "" } }
      end

      it "does not update the bug" do 
        expect(Bug.first.name).to eq(bug.name)
      end
      it "sets an error message" do 
        expect(flash[:alert]).to be_present
      end
      it "renders the edit template" do 
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE#destroy" do 
    it_behaves_like "requires login" do 
      let(:action) {delete :destroy, id: 1}
    end
     
    let (:category) {Fabricate(:category)}
    let (:amanda) {Fabricate(:user)}
    let (:bug) {Fabricate(:bug, user_id: amanda.id, category_id: category.id)} 
    
    before do 
      set_current_user(amanda)
      delete :destroy, {id: bug.id }
    end

    it "deletes the bug" do 
      expect(Bug.count).to eq(0)
    end
    it "sets an info message" do 
      expect(flash[:info]).to be_present
    end
    it "redirects to root_path" do 
      expect(response).to redirect_to(root_path)
    end
  end
end