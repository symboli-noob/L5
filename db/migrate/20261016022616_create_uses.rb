class CreateUses < ActiveRecord::Migration[8.1]
  def change
    create_table :uses do |t|
      t.timestamps
      t.integer :age
    end
  end
end
