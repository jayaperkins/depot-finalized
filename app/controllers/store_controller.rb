class StoreController < ApplicationController

  skip_before_action :authorize

  include CurrentCart
  before_action :set_cart

  def index
    @products = Product.order(:title)

    if params[:set_locale]
      redirect_to store_url(locale: params[:set_locale])
    else
      @products
    end

    if session[:counter].nil?
      @counter = 1
    else
      @counter = session[:counter] + 1
    end
    session[:counter] = @counter
  end
end
