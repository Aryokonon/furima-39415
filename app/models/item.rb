class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  #  has_one :order

  # Image presence validation
  validates :image, presence: { message: "can't be blank" }

  # Name and description presence validations
  validates :name, presence: { message: '商品名が必須です' }
  validates :description, presence: { message: '商品の説明が必須です' }

  # Associations with ActiveHash
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :category, class_name: 'Category'
  belongs_to :condition, class_name: 'Condition'
  belongs_to :delivery_fee, class_name: 'DeliveryFee'
  belongs_to :prefecture, class_name: 'Prefecture'
  belongs_to :shipping_day, class_name: 'ShippingDay', foreign_key: 'shipping_day_id'

  # Validations for association presence
  validates :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :shipping_day_id,
            presence: { message: "can't be blank" }

  # Validations for association numericality
  validates :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :shipping_day_id,
            numericality: { other_than: 1, message: 'must be selected' }

  # Price validations
  validates :price, presence: { message: '価格が必須です' },
                    numericality: {
                      only_integer: true,
                      message: 'は半角数字で入力してください'
                    },
                    inclusion: {
                      in: 300..9_999_999,
                      message: 'は¥300以上、¥9,999,999以下で入力してください'
                    }

  #  def sold_out?
  #    order.present?
  #  end
end
