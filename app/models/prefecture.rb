class Prefecture < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'Hokkaido' },
    { id: 3, name: 'Aomori' }
    # ... add all other prefectures here
  ]

  include ActiveHash::Associations
  has_many :shipping_addresses
end
