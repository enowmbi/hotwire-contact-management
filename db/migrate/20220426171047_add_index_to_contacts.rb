class AddIndexToContacts < ActiveRecord::Migration[7.0]
  def change
    add_index(:contacts, :name, unique: true)
  end
end
