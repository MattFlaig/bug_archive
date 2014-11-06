require 'spec_helper'

describe BugsController do 
  describe "GET#index" do 
    it "sets the @bugs collection" do 
      category = Category.create(name: "Test category") 
      bug1 = Bug.create(name: "first bug", description: "just a bug", message: "Here is a bug",
                            environment: "Test", category_id: category.id)
      bug2 = Bug.create(name: "second bug", description: "just another bug", message: "Here is another bug",
                            environment: "Test", category_id: category.id)
      get :index
      expect(Bug.all).to match_array([bug1,bug2])
    end
  end

  describe "GET#show" do 
    it "sets the @bug variable" do
      category = Category.create(name: "Test category") 
      bug = Bug.create(name: "first bug", description: "just a bug", message: "Here is a bug",
                            environment: "Test", category_id: category.id)
      get :show, id: bug.id
      expect(assigns(:bug)).to eq(bug)
    end
  end

  describe "GET#new" do 
    it "sets the @bug variable" do 
      get :new
      expect(assigns(:bug)).to be_instance_of(Bug)
    end
  end

  describe "POST#create" do 
    context "with valid input" do 
    	before do 
    		category = Category.create(name: "Test Category")
        post :create, {bug: {name: "first bug", description: "just a bug", message: "Here is a bug",
                            environment: "Test", category_id: category.id}}
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
    		category = Category.create(name: "Test Category")
        post :create, {bug: {name: "first bug", description: "just a bug"}}
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