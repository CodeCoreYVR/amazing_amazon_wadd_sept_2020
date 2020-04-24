class ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      render(plain: "Created Product #{@product.inspect}")
    else
      render :new
    end
  end

  private

  def product_params
    # docs about params.require() https://api.rubyonrails.org/classes/ActionController/Parameters.html#method-i-require
    # docs about .permit() https://api.rubyonrails.org/classes/ActionController/Parameters.html#method-i-permit
    params.require(:product).permit(:title, :description, :price, :sale_price)
  end
end
