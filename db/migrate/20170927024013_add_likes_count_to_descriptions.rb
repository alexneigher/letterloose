class AddLikesCountToDescriptions < ActiveRecord::Migration[5.0]
  def change
    add_column :descriptions, :likes_count, :integer, default: 0
  end
end
