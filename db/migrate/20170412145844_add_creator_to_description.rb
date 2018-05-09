class AddCreatorToDescription < ActiveRecord::Migration[5.0]
  def change
    add_column :descriptions, :creator, :string
  end
end
