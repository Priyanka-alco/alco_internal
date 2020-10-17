class Product < ApplicationRecord
  has_and_belongs_to_many :discounts
  has_many :product_details


  def self.active_product
    return Product.where("available=1")
  end
end
