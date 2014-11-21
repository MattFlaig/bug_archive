require 'spec_helper'

describe ListingsController do
  describe "POST#create" do
    it_behaves_like "requires login" do 
      let(:action) {post :create, bug_id: 1}
    end 
  end

  context "with valid input" do
    let (:category) {Fabricate(:category)}
    let (:amanda) {Fabricate(:user)}
    let (:bug) {Fabricate(:bug, user_id: amanda.id, category_id: category.id)}

		before do 
	    set_current_user(amanda)
	    post :create, listing: {snippet:"Blabliblu", user_id: amanda.id, 
	      											listingable_id: bug.id, listingable_type: "bug"}, bug_id: bug.id
		end
    it "creates the code listing" do 
    	expect(Listing.count).to eq(1)
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
	    post :create, listing: {snippet:"", user_id: amanda.id, 
	      											listingable_id: bug.id, listingable_type: "bug"}, bug_id: bug.id
		end
    it "does not create the code listing" do 
    	expect(Listing.count).to eq(0)
    end
    it "sets aa error message" do 
      expect(flash[:alert]).to be_present
    end
    it "renders the show template" do 
      expect(response).to render_template 'bugs/show'
    end
  end


end