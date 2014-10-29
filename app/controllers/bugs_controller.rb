class BugsController < ApplicationController
  def new
    @bug = Bug.new
  end
end