class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @product = Product.find params[:product_id]
    @review = Review.new params.require(:review).permit(:rating, :body)
    @review.product = @product
    @review.user = @current_user
    
    if @review.save
      redirect_to product_path(@product)
    else
      render 'products/show'
    end
  end

  def update
    @review = Review.find params[:id]
    hidden = !@review.hidden
    @review.update(hidden: hidden)
    redirect_to product_path(@review.product)
  end
  
  def destroy
    @review = Review.find params[:id]
    if can?(:crud, @review)
      @review.delete
      redirect_to product_path(@review.product)
    else
      head :unauthorized
    end
  end
end
