class BugsController < ApplicationController
  

  def index
    @bugs = Bug.all
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

  private

  def bug_params
  	params.require(:bug).permit(:name, :description, :message, :environment, :solved?, :category_id)
  end
end