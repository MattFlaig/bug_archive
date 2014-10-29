class BugsController < ApplicationController
  def new
    @bug = Bug.new
    flash[:info] = "Please create a new bug!"
  end
end