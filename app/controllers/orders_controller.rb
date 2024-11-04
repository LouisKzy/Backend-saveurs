class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin, only: [:index]
  before_action :set_order, only: [:show]

  def index
    @orders = Order.all.includes(order_items: :product) 
    render json: @orders.to_json(include: { order_items: { include: :product } })
  end

  def show
    if @order.user_id == current_user.id
      render json: @order.to_json(include: { order_items: { include: :product } })
    else
      render json: { error: 'Accès refusé à cette commande' }, status: :unauthorized
    end
  end

  private

  def authorize_admin
    unless current_user.admin? 
      render json: { error: 'Accès réservé aux administrateurs' }, status: :unauthorized
    end
  end

  def set_order
    @order = Order.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Commande non trouvée' }, status: :not_found
  end
end
