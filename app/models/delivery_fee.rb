class DeliveryFee < ActiveHash::Base
  self.data = [
    { id: 1, name: '-----' },
    { id: 2, name: 'Receiver' },
    { id: 3, name: 'Sender' }
  ]

  include ActiveHash::Associations
  has_many :items
end