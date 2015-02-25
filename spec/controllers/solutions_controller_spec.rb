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

  describe "PUT#update" do 
    let(:amanda) {Fabricate(:user)}
    let(:category) {Fabricate(:category)}
    let(:bug) {Fabricate(:bug, user_id: amanda.id, category_id: category.id)}
    let(:solution) {Fabricate(:solution, bug_id: bug.id)}

    it_behaves_like "requires login" do 
      let(:action) {put :update, bug_id: 1, id: 1}
    end

    context "with valid input" do 
      before do 
        set_current_user(amanda)
        put :update, {bug_id: bug.id, id: solution.id, solution: {solution: "Updated solution"}}
      end
      it "updates the solution" do 
        expect(Solution.first.solution).to eq("Updated solution")
      end
      it "sets a success message" do 
        expect(flash[:success]).to eq("Solution successfully updated.")
      end
      it "redirects to bug show" do 
        expect(response).to redirect_to bug_path(bug.id)
      end
    end

    context "with invalid input" do 
      before do 
        set_current_user(amanda)
        put :update, {bug_id: bug.id, id: solution.id, solution: {solution: ""}}
      end
      it "does not update the solution" do 
        expect(Solution.first.solution).to eq(solution.solution)
      end
      it "sets an error message" do 
        expect(flash[:danger]).to eq("Error while updating solution.")
      end
      it "renders the edit template" do 
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE#destroy" do 
    let(:amanda) {Fabricate(:user)}
    let(:category) {Fabricate(:category)}
    let(:bug) {Fabricate(:bug, user_id: amanda.id, category_id: category.id)}
    let(:solution) {Fabricate(:solution, bug_id: bug.id)}

    it_behaves_like "requires login" do 
      let(:action) {delete :destroy, bug_id: 1, id: 1}
    end

    before do 
      set_current_user(amanda)
      delete :destroy, {bug_id: bug.id, id: solution.id}
    end

    it "deletes the solution" do 
      expect(Solution.count).to eq(0)
    end
    it "sets an info message" do 
      expect(flash[:info]).to be_present
    end
    it "redirects to bug show" do 
      expect(response).to redirect_to(bug_path(bug.id))
    end
  end
end