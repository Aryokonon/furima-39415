class Condition < ActiveHash::Base
  self.data = [
    { id: 1, name: '-----' },
    { id: 2, name: 'New' },
    { id: 3, name: 'Semi-new' },
    { id: 4, name: 'Slightly scratched' },
    { id: 5, name: 'Scratched' },
    { id: 6, name: 'Damaged' },
    { id: 7, name: 'Heavily damaged' }
  ]
end