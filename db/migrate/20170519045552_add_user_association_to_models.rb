class AddUserAssociationToModels < ActiveRecord::Migration[5.0]
  def change
    add_reference :titles, :user
    add_reference :tweaks, :user
    add_reference :descriptions, :user
  end
end
