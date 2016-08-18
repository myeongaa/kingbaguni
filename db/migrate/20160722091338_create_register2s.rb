class CreateRegister2s < ActiveRecord::Migration
  def change
    create_table :register2s do |t|
      t.integer :purchase_id
      t.integer :folder_id
      t.timestamps null: false
    end
  end
end
