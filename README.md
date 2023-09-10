# README

## FURIMA ER Diagram
### Entities and Attributes

#### USERS
- **Relationships**:
  - Has many ITEMS (One to Many)
  - Has many ORDERS (One to Many)
  - USERS can exist without ITEMS
  - USERS can exist without ORDERS
- **Attributes**:
  - User_ID (Primary Key)
  - Username
  - Password
  - Email
  - Address

#### ITEMS
- **Relationships**:
  - Belongs to USERS (Many to One)
  - Has many ORDERS (One to Many)
  - ITEMS cannot exist without USERS
  - ITEMS can exist without ORDERS
- **Attributes**:
  - Item_ID (Primary Key)
  - Name
  - Category
  - Price
  - User_ID (Foreign Key)

#### ORDERS
- **Relationships**:
  - Belongs to one USERS (Many to One)
  - Belongs to one ITEMS (Many to One)
  - ORDERS cannot exist without USERS
  - ORDERS cannot exist without ITEMS
- **Attributes**:
  - Order_ID (Primary Key)
  - User_ID (Foreign Key)
  - Item_ID (Foreign Key)
  - Shipping_Address (Each Order can have only one Shipping Address, but multiple Orders can share the same Shipping Address)



This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
