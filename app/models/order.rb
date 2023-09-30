class Order < ApplicationRecord
  attr_accessor :token

  validates :price,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 300,
              less_than_or_equal_to: 9_999_999,
              message: 'は¥300以上、¥9,999,999以下で入力してください'
            }
  validates :token, presence: true

  belongs_to :user
  belongs_to :item
  has_one :shipping_address, dependent: :destroy
end
