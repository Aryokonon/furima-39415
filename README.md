ER Diagram

![ER Diagram](https://your-image-url.com/your-er-diagram.png)

### Users
| Column                  | Type   | Options                                   |
|-------------------------|--------|-------------------------------------------|
| user_id                 | Integer| Primary Key, null: false, unique: true    |
| user_nickname           | String | null: false                               |
| user_email              | String | null: false, unique: true                 |
| user_password           | String | null: false                               |
| user_password_confirmation | String  | null: false                             |
| user_kanji_name         | String | null: false                               |
| user_kana_name          | String | null: false                               |
| user_birthdate          | Date   | null: false                               |

**Association:**
- Has many items (One to Many)
- Has many orders (One to Many)
- Users can exist without items
- Users can exist without orders
- Logged-in users can post items, buy & sell items through orders
- Non-logged-in users cannot perform the above actions.

### Items
| Column          | Type   | Options                              |
|-----------------|--------|--------------------------------------|
| user_id         | Integer| Foreign Key, null: false             |
| item_id         | Integer| Primary Key, null: false             |
| item_image      | String | null: false                          |
| item_name       | String | null: false                          |
| item_description| Text   | null: false                          |
| item_category   | String | null: false                          |
| item_price      | Integer| null: false                          |

**Association:**
- Belongs to users (Many to One)
- Has many orders (One to Many)
- Items cannot exist without users
- Items can exist without orders

### Orders
| Column     | Type   | Options                                      |
|------------|--------|----------------------------------------------|
| user_id    | Integer| Foreign Key (References Users), null: false  |
| item_id    | Integer| Foreign Key (References Items), null: false  |
| order_id   | Integer| Primary Key, null: false                     |

**Association:**
- Belongs to one user (Many to One)
- Belongs to one item (Many to One)
- Orders cannot exist without users
- Orders cannot exist without items

### Shipping Addresses
| Column             | Type   | Options                                       |
|--------------------|--------|-----------------------------------------------|
| order_id           | Integer| Foreign Key (References Orders), null: false  |
| shipping_id        | Integer| Primary Key, null: false                      |
| shipping_address   | Text   | null: false                                   |
| shipping_postal_code| Integer | null: false                                  |
| shipping_city      | String | null: false                                   |
| shipping_region    | String | null: false                                   |

**Association:**
- Belongs to one order (Many to One)
- Each order can have only one shipping address (null: false),
  but multiple orders can share the same shipping address (null: false)