class RemoveUpvotesFromDescription < ActiveRecord::Migration[5.0]
  def change
    remove_column :descriptions, :upvotes
  end
end
