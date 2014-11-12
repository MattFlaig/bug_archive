class SolutionsController < ApplicationController
  before_action :set_bug
  before_action :set_categories

  def new
    @solution = Solution.new
  end

  def create
    @solution = Solution.new(solution_params)
    @solution.bug = @bug
    if @solution.save
    	flash[:success] = "New solution added."
    	redirect_to bug_path(@bug)
    else
    	render 'bugs/bug_id'
    end
  end

  private

  def set_bug
  	@bug = Bug.find(params[:bug_id])
  end

  def set_categories
    @categories = Category.all
  end

  def solution_params
    params.require(:solution).permit(:solution, :explanation, :related_links)
  end
end