# COMMENTED OUTED

class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :condition, class_name: 'Status', foreign_key: 'status_id'
  belongs_to :shipping_fee
  belongs_to :delivery_date, class_name: 'ShippingDay', foreign_key: 'shipping_day_id'
  belongs_to :prefecture

  validates :name, presence: true
  validates :description, presence: true
  validates :category_id, presence: true
  validates :status_id, presence: true
  validates :delivery_date_id, presence: true
  validates :prefecture_id, presence: true
  validates :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end