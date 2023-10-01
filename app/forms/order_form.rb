# ORDER & SHIPPING_ADDRESS form object to save from
# orders controllers into both "order model / order table" & "shipping_address model / shipping_address table"

class OrderForm
  include ActiveModel::Model
  attr_accessor :price, :token, :postal_code, :city, :street, :phone_number, :prefecture_id, :building_name

  with_options presence: true do
    validates :price, presence: true, numericality: {
      only_integer: true,
      greater_than_or_equal_to: 300,
      less_than_or_equal_to: 9_999_999,
      message: 'は¥300以上、¥9,999,999以下で入力してください'
    }
    validates :token, presence: true
    validates :postal_code, :city, :street, :building_name, :phone_number, presence: true
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    Order.create(price: price, user_id: user_id)
    ShippingAddress.create(postal_code: postal_code, prefecture: prefecture, city: city, house_number: house_number,
                           building_name: building_name, donation_id: donation.id)
  end
end
