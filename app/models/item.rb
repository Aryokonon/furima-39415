
class Item < ApplicationRecord
  
  belongs_to :user
  has_one_attached :image
  has_one :order

  validates :image, presence: { message: "can't be blank" }
  validates :name, presence: { message: "can't be blank" }
  validates :description, presence: { message: "can't be blank" }

  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :category, class_name: 'Category'
  belongs_to :condition, class_name: 'Condition'
  belongs_to :delivery_fee, class_name: 'DeliveryFee'
  belongs_to :prefecture, class_name: 'Prefecture'
  belongs_to :shipping_day, class_name: 'ShippingDay', foreign_key: 'shipping_day_id'

  validates :category_id, presence: { message: "can't be blank" }
  validates :condition_id, presence: { message: "can't be blank" }
  validates :delivery_fee_id, presence: { message: "can't be blank" }
  validates :prefecture_id, presence: { message: "can't be blank" }
  validates :shipping_day_id, presence: { message: "can't be blank" }

  validates :category_id, numericality: { other_than: 1, message: "must be selected" }
  validates :condition_id, numericality: { other_than: 1, message: "must be selected" }
  validates :delivery_fee_id, numericality: { other_than: 1, message: "must be selected" }
  validates :prefecture_id, numericality: { other_than: 1, message: "must be selected" }
  validates :shipping_day_id, numericality: { other_than: 1, message: "must be selected" }

  validates :price, presence: { message: "can't be blank" },
    numericality: { message: "is invalid. Input half-width characters",
      only_integer: true }, inclusion: { in: 300..9_999_999, message: "is out of setting range" }

  def sold_out?
    order.present?
  end
end
