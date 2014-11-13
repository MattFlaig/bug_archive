require 'spec_helper'

describe SolutionsController do 
  describe "GET#new" do 
    let(:amanda) {Fabricate(:user)}
    let(:category) {Fabricate(:category)}
    let(:bug) {Fabricate(:bug, user_id: amanda.id, category_id: category.id)}

    it_behaves_like "requires login" do 
      let(:action) {get :new, bug_id: 1}
    end

    before {set_current_user(amanda)}

    it "sets the @solution variable" do 
      get :new, bug_id: bug.id
      expect(assigns(:solution)).to be_instance_of(Solution)
    end
  end
  describe "POST#create" do
  	let(:amanda) {Fabricate(:user)}
    let(:category) {Fabricate(:category)}
    let(:bug) {Fabricate(:bug, user_id: amanda.id, category_id: category.id)}

    it_behaves_like "requires login" do 
      let(:action) {post :create, bug_id: 1}
    end

    before {set_current_user(amanda)}
    
    context "with valid input" do
      before{post :create, solution: Fabricate.attributes_for(:solution), bug_id: bug.id} 
      
      it "creates a new solution" do
      	expect(Solution.count).to eq(1)
      end
      it "associates bug with solution" do 
      	expect(Solution.first.bug.name).to eq(bug.name)
      end
      it "sets a success message" do 
        expect(flash[:success]).to be_present
      end
      it "redirects to bug show" do 
        expect(response).to redirect_to bug_path(bug)
      end
    end

    context "with invalid input" do
      before { post :create, solution: {explanation: "Because this is a non-valid solution"}, bug_id: bug.id } 

      it "does not create a solution" do 
        expect(Solution.count).to eq(0)
      end
      it "renders bug show" do 
        expect(response).to render_template('bugs/show')
      end
    end
  end
end