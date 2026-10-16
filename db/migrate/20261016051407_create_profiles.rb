class CreateProfiles < ActiveRecord::Migration[8.1]
  def change
    create_table :profiles do |t|
      t.string :message
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :profiles, :user_id, unique: true
    add_foreign_key :profiles, :users
  end
end