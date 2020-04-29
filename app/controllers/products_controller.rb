class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_product!, except: [:create]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @products = Product.all.order('created_at DESC')
  end

  def new
  end

  def create
    @product = Product.new product_params
    @product.user = @current_user
    if @product.save
      render(plain: "Created Product #{@product.inspect}")
    else
      render :new
    end
  end

  def show
    @review = Review.new
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  def edit
  end

  def update
    if @product.update product_params
      redirect_to product_path @product
    else
      render :edit
    end
  end

  private

  def product_params
    # docs about params.require() https://api.rubyonrails.org/classes/ActionController/Parameters.html#method-i-require
    # docs about .permit() https://api.rubyonrails.org/classes/ActionController/Parameters.html#method-i-permit
    params.require(:product).permit(:title, :description, :price, :sale_price)
  end

  def authorize_user!
    unless can? :crud, @product
      flash[:danger] = "Access Denied"
      redirect_to root_path
    end
  end

  def load_product!
    if params[:id].present?
      @product = Product.find(params[:id])
    else
      @product = Product.new
    end
  end
end


