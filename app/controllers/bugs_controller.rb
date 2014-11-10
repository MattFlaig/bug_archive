class BugsController < ApplicationController
  before_action :set_categories
  before_action :require_user
  def index
    @bugs = Bug.all
  end

  def show
    @bug = Bug.find(params[:id])
  end

  def new
    @bug = Bug.new
  end

  def create
    @bug = Bug.new(bug_params)
    if @bug.save
      flash[:success] = "New Bug created!"
      redirect_to bugs_path
    else
      flash[:alert] = "There is something wrong with your input!"
    	render 'new'
    end 
  end

  def search
    @results = Bug.search_by_name(params[:search_term])
  end

  private

  def bug_params
  	params.require(:bug).permit(:name, :description, :message, :environment, :solved?, :category_id)
  end

  def set_categories
    @categories = Category.all
  end
end