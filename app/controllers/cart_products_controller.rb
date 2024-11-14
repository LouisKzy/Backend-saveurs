class CartProductsController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def create
    product = Product.find(params[:productId])
    cart = current_user.cart
    new_quantity = params[:quantity].to_i
    existing_cart_product = cart.cart_products.find_by(product_id: product.id)
  
    if existing_cart_product
      updated_quantity = existing_cart_product.quantity + new_quantity
  
      if existing_cart_product.update(quantity: updated_quantity)
        render json: { message: 'Cart updated successfully', new_quantity: updated_quantity }, status: :ok
      else
        render json: { errors: existing_cart_product.errors.full_messages }, status: :unprocessable_entity
      end
    else
      cart_product = cart.cart_products.build(product: product, quantity: new_quantity)
  
      if cart_product.save
        render json: { message: 'Product added to cart successfully', quantity: cart_product.quantity }, status: :created
      else
        render json: { errors: cart_product.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
  
  

  def update
    cart_product = CartProduct.find(params[:id])

    if cart_product.update(cart_product_params)
      render json: { message: 'Cart product updated successfully' }, status: :ok
    else
      render json: { errors: cart_product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    product = Product.find(params[:productId])
    cart = current_user.cart
    cart_product = cart.cart_products.find_by(product_id: product.id)

    if cart_product
      cart_product.destroy
      render json: { message: 'Product removed from cart successfully' }, status: :ok
    else
      render json: { error: 'Product not found in cart' }, status: :not_found
    end
  end
  
  def cart_product_params
    params.require(:cart_product).permit(:product_id, :quantity, :id)
  end
end
