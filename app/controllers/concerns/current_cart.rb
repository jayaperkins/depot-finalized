module CurrentCart
  extend ActiveSupport::Concern

  private

    def set_cart
      @cart = Cart.find(session[:cart_id]) #look in the session for a cart id to determine if a cart exists
    rescue ActiveRecord::RecordNotFound
      @cart = Cart.create
      session[:cart_id] = @cart.id #creates a new cart if an existing cart is not discovered in the database
    end

end