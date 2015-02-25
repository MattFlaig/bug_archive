class ConceptsController < ApplicationController
  before_action :set_categories
  before_action :require_user

  def index 
  	@concepts = current_user.concepts
  end
  	
  def new
    @concept = Concept.new
  end

  def create
    @concept = Concept.new(concept_params.merge!(user: current_user))

    if @concept.save
      flash[:success] = "New Concept created!"
      redirect_to concepts_path
    else
    	flash[:danger] = "There is something wrong with your input."
    	render 'new'
    end
  end



  private

  def concept_params
  	params.require(:concept).permit(:term, :concept_text)
  end 

  def set_categories
    @categories = Category.all
  end


end