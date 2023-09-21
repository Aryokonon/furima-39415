class ShippingDay < ActiveHash::Base
  self.data = [
    { id: 1, name: '-----' },
    { id: 2, name: '1-2' },
    { id: 3, name: '2-3' },
    { id: 4, name: '4-7' }
  ]

  include ActiveHash::Associations
  has_many :items
end