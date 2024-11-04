class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_admin, only: [:create, :update, :destroy]
  before_action :set_product, only: [:show, :update, :destroy]

  def index
    if current_user && current_user.admin?
      products = Product.all
    else
      products = Product.all.where(active: true)
    end

    if params[:name].present?
      products = products.where("name ILIKE ?", "%#{params[:name]}%")
    end

    render json: products.as_json(methods: :img_url)
  end

  def show
    @product = Product.find(params[:id])
    render json: @product.as_json(methods: :img_url)
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @product.destroyable?
      if @product.destroy
        head :no_content
      else
        render json: { error: 'Une erreur a eu lieu lors de la suppression' }, status: :unprocessable_entity
      end
    else
      @product.active = !@product.active
      if @product.save
        render json: { message: 'Le statut du produit a été mis à jour' }, status: :ok
      else
        render json: { error: 'Impossible de mettre à jour le statut du produit' }, status: :unprocessable_entity
      end
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :image, :price, :description, :origin, :variety, :category)
    end
    
    def authorize_admin
      unless current_user && current_user.admin?
        render json: { error: 'Vous n\'avez pas accès à cette ressource' }, status: :unauthorized
      end
    end
    
end
