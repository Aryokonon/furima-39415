class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '-----' },
    { id: 2, name: 'Ladies' },
    { id: 3, name: 'Mens' },
    { id: 4, name: 'Baby/Kids' },
    { id: 5, name: 'Interia' },
    { id: 6, name: 'Books' },
    { id: 7, name: 'Toys' },
    { id: 8, name: 'Cellphones' },
    { id: 9, name: 'Sports' },
    { id: 10, name: 'Handmade' },
    { id: 11, name: 'Others' }
  ]
end