# # COMMENTED OUTED
#
# class ShippingAddress < ApplicationRecord
#   belongs_to :order
#   extend ActiveHash::Associations::ActiveRecordExtensions
#   belongs_to :prefecture, class_name: 'Prefecture'
#
#   validates :postal_code, :city, :street, :phone_number, presence: true
#   validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
# end
