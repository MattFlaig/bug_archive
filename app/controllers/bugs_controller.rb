class BugsController < ApplicationController
  
  def new
    @bug = Bug.new
    flash[:info] = "Please create a new bug!"
  end

  def create
    @bug = Bug.new(bug_params)
    if @bug.save
      flash[:success] = "New Bug created!"
      redirect_to bugs_path
    else
    	render 'new'
    end 
  end

  private

  def bug_params
  	params.require[:bug].permit(:name, :description, :message, :environment, :solved?, :category_id)
  end
end