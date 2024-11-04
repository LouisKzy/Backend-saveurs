# app/models/order.rb

class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  after_create :confirmation_order

  def confirmation_order
    OrderMailer.confirmation_order(self).deliver_now
  end
end