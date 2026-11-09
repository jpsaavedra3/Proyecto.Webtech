class AddPasswordAndProfileToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :password_digest, :string
    add_column :users, :phone, :string
    add_column :users, :bio, :text
  end
end
