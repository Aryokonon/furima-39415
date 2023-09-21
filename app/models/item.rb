class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  
  belongs_to :user
  belongs_to :category
  belongs_to :condition, class_name: 'ItemCondition'
  belongs_to :delivery_fee, class_name: 'DeliveryFee'
  belongs_to :shipping_day, class_name: 'ShippingDay', foreign_key: 'shipping_day_id'
  belongs_to :prefecture, class_name: 'Prefecture'

  has_one :order
  
  validates :name, :description, :price, :shipping_day_id, presence: true
  validates :category_id, :condition_id, :delivery_fee_id, :delivery_date_id, :prefecture_id, presence: true, numericality: { other_than: 0 }
  validates :price, presence: true, numericality: { presence: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
end