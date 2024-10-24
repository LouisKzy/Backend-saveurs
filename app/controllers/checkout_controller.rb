class CheckoutController < ApplicationController
  before_action :authenticate_user!

  def create
    @total = params[:total].to_d
    @cart_id = params[:cart_id]
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            currency: 'eur',
            unit_amount: (@total * 100).to_i,
            product_data: {
              name: 'Paiement en ligne',
            },
          },
          quantity: 1,
        },
      ],
      mode: 'payment',
      customer_email: current_user.email,
      success_url: 'https://saveurs-saisonnieres.vercel.app/payment/success#session_id={CHECKOUT_SESSION_ID}',
      cancel_url: 'https://saveurs-saisonnieres.vercel.app/payment/cancel',
    )

    # Assigner l'ID de session à la métadonnée après avoir créé la session
    @session.metadata = { session: @session.id }
    
    render json: { sessionUrl: @session.url, session: @session.id }
  end

  def success
    # Utiliser le bon paramètre pour récupérer l'ID de session
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    @user = current_user
    @total = current_user.cart.cart_products.sum { |cart_item| cart_item.product.price * cart_item.quantity }
    @order = Order.new(user_id: current_user.id, total_price: @total)
  
    if @order.save
      create_order_items(current_user.cart.cart_products)
      clear_user_cart if @payment_intent.status == 'succeeded'
      render json: { message: 'Order created successfully' }, status: :created
    else
      render json: { error: 'Failed to create order' }, status: :unprocessable_entity
    end
  end

  private 

  def create_order_items(cart_products)
    cart_products.each do |cart_product|
      order_item = @order.order_items.build(
        product_id: cart_product.product_id,
        quantity: cart_product.quantity
      )
      order_item.save
    end
  end

  def clear_user_cart
    current_user.cart.cart_products.destroy_all
  end
end
