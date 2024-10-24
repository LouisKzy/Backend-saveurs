class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: %i[show]
  respond_to :json  
  # GET /cart

def show
  cart = current_user.cart
  cart_products = cart.cart_products.includes(:product)
  products_with_quantity = cart_products.map do |cart_product|
    {
      product: cart_product.product,
      quantity: cart_product.quantity,
      cart_product_id: cart_product.id  # Ajoutez l'ID du cart_product associé au produit
    }
  end
  render json: { cart_id: cart.id, products: products_with_quantity }
end
  
  private

  # Use callbacks to share common setup or constraints between actions.
  def set_cart
    @cart = current_user.cart || current_user.build_cart
  end
end
