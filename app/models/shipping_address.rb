class ShippingAddress < ApplicationRecord
  belongs_to :order
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture, class_name: 'Prefecture'
end
