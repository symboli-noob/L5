class RenamePassToPasswordDigest < ActiveRecord::Migration[8.1]
  def change
    rename_column :users, :pass, :password_digest
  end
end