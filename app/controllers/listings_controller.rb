class ListingsController < ApplicationController
  before_action :set_categories
  before_action :require_user

  def new
    @bug = Bug.find(params[:bug_id])
    # @solution = Solution.find(params[:solution_id])

    if params[:solution_id] 
      @object = Solution.find(params[:solution_id]) 
    else
      @object = nil
    end
    @listing = Listing.new
  end

  def create
    @bug = Bug.find(params[:bug_id])
    # @solution = Solution.find(params[:solution_id])
    if params[:solution_id] 
      @object = Solution.find(params[:solution_id]) 
      @listing = @object.listings.build(listing_params.merge!(user: current_user))
    else
      @object = nil
      @listing = @bug.listings.build(listing_params.merge!(user: current_user))
    end
    
    
    if @listing.save
      flash[:success] = "New listing added."
      redirect_to bug_path(@bug)
    else
      flash[:danger] = "Error while creating listing. Please add a snippet."
      render 'bugs/show'
    end

  end

  private

  def set_categories
    @categories = Category.all
  end

  def listing_params
    params.require(:listing).permit(:snippet, :user_id, :listingable_type, :listingable_id, :filename)
  end

end