class BugsController < ApplicationController
  before_action :set_categories
  before_action :require_user
  before_action :set_bug, except: [:index, :search, :new, :create]

  require 'pry'

  def index
    @bugs = Bug.all
  end

  def show
    
  end

  def show_concept
    @concept = Concept.find(params[:concept])
    @solution = Solution.find(params[:solution])

    respond_to do |format|
      format.html {redirect_to :back}
      format.js 
    end
    # binding.pry
  end

  def new
    @bug = Bug.new
  end

  def create
    @bug = Bug.new(bug_params.merge!(user: current_user))
    # binding.pry
    if @bug.save
      flash[:success] = "New Bug created!"
      redirect_to root_path
    else
      flash[:danger] = "There is something wrong with your input!"
    	render 'new'
    end 
  end

  def edit
    
  end

  def update
  
    if @bug.update(bug_params)
      flash[:success] = "Bug successfully updated."
      redirect_to bug_path(@bug)
    else
      flash[:danger] = "Error while updating bug."
      render 'edit'
    end
  end

  def destroy
   
    @bug.destroy
    flash[:info] = "Bug has been deleted."
    redirect_to root_path
  end

  def search
    @results = Bug.search_by_name(params[:search_term])
    render "search"
  end

  private

  def bug_params
  	params.require(:bug).permit(:name, :description, :message, :environment, :category_id, :user_id)
  end

  def set_categories
    @categories = Category.all
  end

  def set_bug
    @bug = Bug.find(params[:id])
  end
end