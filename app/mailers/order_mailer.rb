class OrderMailer < ApplicationMailer
    def confirmation_order(order)
        @order = order
        @user = @order.user
        @order_items = @order.order_items.includes(:product)
        mail(to: @order.user.email, subject: 'Confirmation de votre commande chez Saveurs Saisonières')
    end
end