class AddAcknowledgedToLikes < ActiveRecord::Migration[5.0]
  def change
    add_column :likes, :acknowledged, :boolean, default: false
  end
end
