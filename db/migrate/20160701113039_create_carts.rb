class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.string :name
      t.string :url
      t.string :s_name
      t.integer :price , :limit => 30 ,:default => 0
      t.integer :d_price , :limit => 30 ,:default => 0
      t.integer :total , :limit => 30 ,:default => 0
      t.integer :user_id
      t.integer:category
      t.integer :fol
      t.string :image_url,  default: ""
      t.integer :cart_id
      t.timestamps null: false
    end
  end
end
