class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_admin, only: [:create, :update, :destroy]
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
    @products = Product.all

    render json: @products.as_json(methods: :img_url)
  end

  # GET /products/1
  def show
    @product = Product.find(params[:id])
    render json: @product.as_json(methods: :img_url)
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
# DELETE /products/1
  def destroy
    if @product.destroy
      head :no_content
    else
      render json: { error: 'Une erreur a eu lieu lors de la suppression' }, status: :unprocessable_entity
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :image, :price, :description, :origin, :variety, :categorie)
    end
    
    def authorize_admin
      unless params[:isAdmin] == "true"
        render json: { error: 'Vous n\'avez pas accès à cette ressource' }, status: :unauthorized
      end
    end
    
end
