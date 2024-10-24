class UserCartsController < ApplicationController
  before_action :set_user_cart, only: %i[ show update destroy ]

  # GET /user_carts
  def index
    @user_carts = UserCart.all

    render json: @user_carts
  end

  # GET /user_carts/1
  def show
    render json: @user_cart
  end

  # POST /user_carts
  def create
    @user_cart = UserCart.new(user_cart_params)

    if @user_cart.save
      render json: @user_cart, status: :created, location: @user_cart
    else
      render json: @user_cart.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_carts/1
  def update
    if @user_cart.update(user_cart_params)
      render json: @user_cart
    else
      render json: @user_cart.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_carts/1
  def destroy
    @user_cart.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_cart
      @user_cart = UserCart.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_cart_params
      params.require(:user_cart).permit(:user_id, :cart_id)
    end
end
