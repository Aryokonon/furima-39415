class CreateActiveStorageTables < ActiveRecord::Migration[5.2]
  def change
    create_table :active_storage_blobs do |t|
      t.string   :key,        null: false
      t.string   :filename,   null: false
      t.string   :content_type
      t.text     :metadata
      t.bigint   :byte_size,  null: false
      t.string   :checksum,   null: false
      t.datetime :created_at, null: false

      t.index [ :key ], unique: true
    end

    create_table :active_storage_attachments do |t|
      t.string     :name,     null: false
      t.references :record,   null: false, polymorphic: true, index: false
      t.references :blob,     null: false

      t.datetime :created_at, null: false

      t.index [ :record_type, :record_id, :name, :blob_id ], name: "index_active_storage_attachments_uniqueness", unique: true
      t.foreign_key :active_storage_blobs, column: :blob_id
    end

    # Additional modifications based on the ER Diagram
    create_table :users do |t|
      t.string :nickname, null: false
      t.string :email, null: false, unique: true
      t.string :encrypted_password, null: false
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :last_name_kana, null: false
      t.string :first_name_kana, null: false
      t.date :birthdate, null: false

      t.timestamps
    end

    create_table :items do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description, null: false
      t.integer :category_id, null: false
      t.integer :condition_id, null: false
      t.integer :delivery_fee_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :shipping_day_id, null: false
      t.integer :price, null: false

      t.timestamps
    end

    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end

    create_table :shipping_addresses do |t|
      t.references :order, null: false, foreign_key: true
      t.string :postal_code, null: false
      t.integer :prefecture_id, null: false
      t.string :city, null: false
      t.string :street, null: false
      t.string :building_name
      t.string :phone_number, null: false

      t.timestamps
    end
  end
end