class OrderForm
  include ActiveModel::Model

  attr_accessor :price, :token, :postal_code, :city, :street, :phone_number, :prefecture_id, :building_name, :user, :item,
                :item_id

  with_options presence: true do
    validates :price, numericality: {
      only_integer: true,
      greater_than_or_equal_to: 300,
      less_than_or_equal_to: 9_999_999,
      message: 'は¥300以上、¥9,999,999以下で入力してください'
    }
    validates :token, :postal_code, :city, :street, :phone_number, presence: true
  end

  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def initialize(user:, item:)
    @user = user
    @item = item
  end

  # Save the order and associated shipping address
  def save
    order = Order.create(user: user, item: item)
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
