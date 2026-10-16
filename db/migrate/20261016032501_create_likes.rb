class CreateLikes < ActiveRecord::Migration[8.1]
  def change
    create_table :likes do |t|
      t.integer :user_id, null: false
      t.integer :tweet_id, null: false

      t.timestamps
    end

    add_index :likes, [:user_id, :tweet_id], unique: true
    add_foreign_key :likes, :users
    add_foreign_key :likes, :tweets
  end
end