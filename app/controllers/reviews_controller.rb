class ReviewsController < ApplicationController

  before_action :require_login

  def create

    @review = Review.create(review_params)
    # @review.user_id = current_user.id
    @current_user = User.find(current_user)
    @review.user_id = @current_user.id
    # @review.user_id = 1
    @review.product_id = params[:products_id]
    
    puts "ROHIT "
    puts params
    puts @review.inspect
    if @review.save!
      puts "WE ARE SAVING"
      redirect_to :back
    else
      puts "WE ARE IN ELSE PART"
      render json: @review.errors, status: :bad_request
    end
    
  end

  def destroy
    Review.find(params[:id]).destroy
    redirect_to "/products/#{params[:product_id]}"
  end


  private

  def add_user_id
    @review.user = current_user
  end

  def review_params
    params.require(:reviews).permit(:rating, :description)
  end
 
  def require_login

    unless current_user
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_session_path
    end
  end

end