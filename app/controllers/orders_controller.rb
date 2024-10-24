class OrdersController < ApplicationController
  before_action :authorize_admin, only: %i[ index ]

  # GET /orders
  def index
    @orders = Order.all
    render json: @orders
  end

  private
    def authorize_admin
      unless params[:isAdmin] == "true"
        render json: { error: 'Vous n\'avez pas accès à cette ressource' }, status: :unauthorized
      end
    end
    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:user_id, :order_date, :status, :isAdmin)
    end
end
