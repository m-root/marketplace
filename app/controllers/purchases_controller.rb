class PurchasesController < ApplicationController
  before_action :authenticate_user!

  add_breadcrumb "Dashboard", :dashboard_path
  add_breadcrumb "Purchases History", :dashboard_purchase_history_path

  layout "dashboard"

  def index
    @purchases = current_user.purchases.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.find(params[:id])
    @purchase = current_user.purchases.new(product: @product)
    if @purchase.save
      flash[:success] = "Your purchase was successful!"
      redirect_to shop_product_path(@product.shop, @product)
    end
  end

end
