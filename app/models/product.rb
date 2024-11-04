class Product < ApplicationRecord
  has_many :cart_products
  has_many :carts, through: :cart_products
  has_one_attached :image
  has_many :order_items
  has_many :orders, through: :order_items

  scope :active, -> { where(active: true) }
  def img_url
    Rails.application.routes.url_helpers.rails_blob_url(self.image, only_path: true)
  end
  def destroyable?
    order_items.empty?
  end
  validates :name, length: { minimum: 3, maximum: 50 }, presence: true
  validates :price, numericality: { greater_than: 0, message: "Doit être supérieur à 0" }, presence: true
  validates :description, length: { minimum: 10, maximum: 150 }, presence: true
  validates :origin, presence: true
  validates :variety, presence: true
  validates :category, presence: true
end
