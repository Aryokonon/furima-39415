class Item < ApplicationRecord
  belongs_to :user
  has_one :order

  # Validations
  validates :name, :description, :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :shipping_day_id, :price,
            presence: true
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end
