class ProductImagesController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    product.image.attach(params[:image])
    render json: product
  end

  def update
    product = Product.find(params[:product_id])
    product.image.purge if product.image.attached?
    product.image.attach(params[:image])
    render json: product
  end

  def destroy
    product = Product.find(params[:product_id])
    product.image.purge
    render json: { message: 'Image deleted successfully' }
  end
end
