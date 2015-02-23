require 'spec_helper'

describe ConceptsController do
  describe "GET#new" do 
    it "sets the @concept variable" do
      category = Fabricate(:category)
      amanda = Fabricate(:user) 
      bug = Fabricate(:bug, user_id: amanda.id, category_id: category.id)
      solution = Fabricate(:solution, bug_id: bug.id)
      get :new, bug_id: bug.id, solution_id: solution.id
      expect(assigns(:concept)).to be_instance_of(Concept)
    end

  end


end