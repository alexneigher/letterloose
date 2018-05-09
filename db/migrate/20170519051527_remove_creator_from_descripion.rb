class RemoveCreatorFromDescripion < ActiveRecord::Migration[5.0]
  def change
    remove_column :descriptions, :creator
  end
end
