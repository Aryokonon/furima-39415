class Order < ApplicationRecord
  validates :price,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 300,
              less_than_or_equal_to: 9_999_999,
              message: 'は¥300以上、¥9,999,999以下で入力してください'
            }
  validates :token, presence: true
  validates :postal_code, presence: true, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }

  belongs_to :user
  belongs_to :item
  has_one :shipping_address, dependent: :destroy
end