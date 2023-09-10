# README

## FURIMA ER Diagram

### USERS
| Column    | Type    | Options                                   |
|-----------|---------|-------------------------------------------|
| User_ID   | Integer | Primary Key, null: false, unique: true    |
| Username  | String  | null: false                              |
| Password  | String  | null: false                              |
| Email     | String  | null: false, unique: true                |
| Address   | Text    | null: false                              |
### Association
- Has many ITEMS (One to Many)
- Has many ORDERS (One to Many)
- USERS can exist without ITEMS
- USERS can exist without ORDERS
- Logged-in Users can post Items, buy & sell items through Orders
- Non-logged-in Users cannot perform the above actions.

### ITEMS
| Column   | Type    | Options                              |
|----------|---------|--------------------------------------|
| Item_ID  | Integer | Primary Key, null: false             |
| Name     | String  | null: false                          |
| Category | String  | null: false                          |
| Price    | Integer | null: false                          |
| User_ID  | Integer | Foreign Key, null: false             |
### Association
- Belongs to USERS (Many to One)
- Has many ORDERS (One to Many)
- ITEMS cannot exist without USERS
- ITEMS can exist without ORDERS

### ORDERS
| Column          | Type    | Options                                          |
|-----------------|---------|--------------------------------------------------|
| Order_ID        | Integer | Primary Key, null: false                         |
| User_ID         | Integer | Foreign Key (References USERS), null: false     |
| Item_ID         | Integer | Foreign Key (References ITEMS), null: false     |
| Shipping_Address| Text    | null: false                                      |
### Association
- Belongs to one USERS (Many to One)
- Belongs to one ITEMS (Many to One)
- ORDERS cannot exist without USERS
- ORDERS cannot exist without ITEMS
- Each Order can have only one Shipping Address (null: false),
but multiple Orders can share the same Shipping Address (null: false)