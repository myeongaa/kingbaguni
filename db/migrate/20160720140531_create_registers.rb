class CreateRegisters < ActiveRecord::Migration
  def change
    create_table :registers do |t|
      t.integer :cart_id
      t.integer :folder_id
      t.timestamps null: false
    end
  end
end
