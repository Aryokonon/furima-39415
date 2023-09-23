# COMMENTED OUTED

class Order < ApplicationRecord
  attr_accessor :token

  validates :price, presence: true
  validates :token, presence: true
end

belongs_to :user
belongs_to :item
has_one :shipping_address, dependent: :destroy

#  # You probably don't need to validate user_id and item_id as they are managed by Rails through belongs_to
# end
