class RemoveEmailFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_index :users, :email
    remove_column :users, :email, :string
  end
end
