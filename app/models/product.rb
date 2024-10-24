class Product < ApplicationRecord
  has_many :cart_products
  has_many :carts, through: :cart_products
  has_one_attached :image

  def img_url
    Rails.application.routes.url_helpers.rails_blob_url(self.image, only_path: true)
  end
  validates :name, length: { minimum: 3, maximum: 50 }, presence: true
  validates :price, numericality: { greater_than: 0,message: "Doit etre superieur a 0" }, presence: true
  validates :description, length: { minimum: 10, maximum: 150}, presence: true
  validates :origin, presence: true
  validates :variety, presence: true
end
