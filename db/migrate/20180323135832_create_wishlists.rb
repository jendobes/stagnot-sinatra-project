class CreateWishlists < ActiveRecord::Migration[5.1]
  def change
    create_table :wishlists do |t|
      t.integer :user_id
      t.integer :todo_id
    end
  end
end
