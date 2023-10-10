class OrderForm
  include ActiveModel::Model

  attr_accessor :token, :postal_code, :city, :street, :phone_number, :prefecture_id, :building_name, :user_id, :item_id

  with_options presence: true do
    validates :user_id, :token, :city, :building_name, :street, presence: true
    validates :postal_code, presence: true, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/, message: 'should be 10 to 11 digits' }
  end

  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    ActiveRecord::Base.transaction do
      order = Order.create(user_id: user_id, item_id: item_id)
      return false unless order.valid?

      shipping_address = ShippingAddress.create(
        order: order,
        postal_code: postal_code,
        prefecture_id: prefecture_id,
        city: city,
        street: street,
        building_name: building_name,
        phone_number: phone_number
      )

      order.valid? && shipping_address.valid?
    end
  end
end
