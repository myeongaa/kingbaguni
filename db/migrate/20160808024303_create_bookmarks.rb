class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string :name
      t.string :url
      t.integer :user_id
      t.integer :book_id
      t.timestamps null: false
    end
  end
end
