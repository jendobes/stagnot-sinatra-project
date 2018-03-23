class CreateCompletes < ActiveRecord::Migration[5.1]
  def change
    create_table :completes do |t|
      t.integer :user_id
      t.integer :todo_id
    end
  end
end
