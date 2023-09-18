class Order < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :shipping_address

  # You probably don't need to validate user_id and item_id as they are managed by Rails through belongs_to
end
