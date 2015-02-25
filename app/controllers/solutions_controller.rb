class SolutionsController < ApplicationController
  before_action :require_user
  before_action :set_bug
  before_action :set_categories
  require 'pry'

  def new
    @solution = Solution.new
    @concepts = Concept.all
    # binding.pry
  end

  def create
    @solution = Solution.new(solution_params)
    @solution.bug = @bug
    # @concepts = Concept.all
    # @solution.concepts = Concept.find WHERE params[:concept_ids]
    binding.pry

    if @solution.save
    	flash[:success] = "New solution added."
    	redirect_to bug_path(@bug)
    else
      #@solutions = @bug.solutions.reload
    	render 'bugs/show'
    end
  end

  def edit
    @solution = Solution.find(params[:id])
  end

  def update
    @solution = Solution.find(params[:id])
    if @solution.update(solution_params)
      flash[:success] = "Solution successfully updated."
      redirect_to bug_path(@bug)
    else
      flash[:danger] = "Error while updating solution."
      render 'edit'
    end
  end

  def destroy
    @solution = Solution.find(params[:id])
    @solution.destroy
    flash[:info] = "Solution deleted."
    redirect_to bug_path(@bug)
  end

  private

  def set_bug
  	@bug = Bug.find(params[:bug_id])
  end

  def set_categories
    @categories = Category.all
  end

  def solution_params
    params.require(:solution).permit! #(:solution, :explanation, :related_links, :concept_ids)
  end
end