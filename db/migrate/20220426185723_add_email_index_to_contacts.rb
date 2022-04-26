class AddEmailIndexToContacts < ActiveRecord::Migration[7.0]
  def change
    add_index :contacts, :email, unique: true
    add_index :contacts, [:name, :email], unique: true
  end
end
