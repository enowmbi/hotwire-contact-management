class RemoveColumnsFromContacts < ActiveRecord::Migration[7.0]
  def change
    remove_column(:contacts, :address, :string)
    remove_column(:contacts, :phone, :string)
  end
end
