class RemoveDownvotesFromDescriptions < ActiveRecord::Migration[5.0]
  def change
    remove_column :descriptions, :downvotes
  end
end
