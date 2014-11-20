class BugsController < ApplicationController
  before_action :set_categories
  before_action :require_user
  require 'pry'

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
    @bug = Bug.new(bug_params.merge!(user: current_user))
    # binding.pry
    if @bug.save
      flash[:success] = "New Bug created!"
      redirect_to root_path
    else
      flash[:alert] = "There is something wrong with your input!"
    	render 'new'
    end 
  end

  def edit
    @bug = Bug.find(params[:id])
  end

  def update
    @bug = Bug.find(params[:id])
    if @bug.update(bug_params)
      flash[:success] = "Bug successfully updated."
      redirect_to bug_path(@bug)
    else
      flash[:alert] = "Error while updating bug."
      render 'edit'
    end
  end

  def destroy
    @bug = Bug.find(params[:id])
    @bug.destroy
    flash[:info] = "Bug has been deleted."
    redirect_to bug_path(@bug) 
  end

  def search
    @results = Bug.search_by_name(params[:search_term])
  end

  private

  def bug_params
  	params.require(:bug).permit(:name, :description, :message, :environment, :category_id, :user_id)
  end

  def set_categories
    @categories = Category.all
  end
end