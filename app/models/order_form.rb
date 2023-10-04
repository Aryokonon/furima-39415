class OrderForm
  include ActiveModel::Model

  attr_accessor :price, :token, :postal_code, :city, :street, :phone_number, :prefecture_id, :building_name, :user_id, :item_id

  with_options presence: true do
    validates :price, numericality: {
      only_integer: true,
      greater_than_or_equal_to: 300,
      less_than_or_equal_to: 9_999_999,
      message: 'は¥300以上、¥9,999,999以下で入力してください'
    }
    validates :user_id, :token, :city, :street, :phone_number, presence: true
    validates :postal_code, presence: true, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
  end

  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    order = Order.create(user_id: user_id, item_id: item_id, token: token)
    ShippingAddress.create(
      order: order,
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      street: street,
      building_name: building_name,
      phone_number: phone_number
    )
  end
end