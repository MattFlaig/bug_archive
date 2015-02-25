require 'spec_helper'

describe ConceptsController do
  describe "GET#new" do 
    it "sets the @concept variable" do
      amanda = Fabricate(:user) 
      set_current_user(amanda)
      get :new
      expect(assigns(:concept)).to be_instance_of(Concept)
    end
  end

  describe "POST#create" do 
    context "with valid input" do 
      let(:amanda) {Fabricate(:user)}

      before do 
        set_current_user(amanda)
        post :create, concept: {term: "test", concept_text: "test concept", user_id:amanda.id} 
      end

      it "creates a new concept" do 
        expect(Concept.count).to eq(1)
      end
      it "sets a success message" do
        expect(flash[:success]).to be_present
      end
      it "redirects to concepts index" do 
        expect(response).to redirect_to concepts_path
      end
    end

    context "with invalid input" do 
      let(:amanda) {Fabricate(:user)}

      before do 
        set_current_user(amanda)
        post :create, concept: {term: "", user_id:amanda.id} 
      end

      it "does not create a new concept" do 
        expect(Concept.count).to eq(0)
      end
      it "sets an error message" do
        expect(flash[:danger]).to be_present
      end
      it "renders the new template" do 
        expect(response).to render_template :new
      end
    end

  end


end