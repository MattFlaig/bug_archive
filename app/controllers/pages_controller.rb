class PagesController < ApplicationController
  def home
  	redirect_to bugs_path if current_user
  end
end