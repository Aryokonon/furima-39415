class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.integer :category_id
      t.integer :condition_id
      t.integer :delivery_fee_id
      t.integer :prefecture_id
      t.integer :shipping_day_id
      t.integer :price
    end
  end
end
