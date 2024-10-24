class CartProductsController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  # POST /cart_products
  def create
    product = Product.find(params[:productId])
    cart = current_user.cart
  
    # Vérifier si le produit existe déjà dans le panier de l'utilisateur
    if cart.cart_products.exists?(product_id: product.id)
      render json: { error: 'Product already exists in cart' }, status: :unprocessable_entity
      return
    end
  
    cart_product = cart.cart_products.build(product: product)
  
    if cart_product.save
      render json: { message: 'Product added to cart successfully' }, status: :created
    else
      render json: { errors: cart_product.errors.full_messages }, status: :unprocessable_entity
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
  
    # Rechercher l'élément du panier correspondant au produit à supprimer
    cart_product = cart.cart_products.find_by(product_id: product.id)
  
    # Vérifier si l'élément du panier existe
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
