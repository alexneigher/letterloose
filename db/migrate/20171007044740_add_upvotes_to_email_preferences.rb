class AddUpvotesToEmailPreferences < ActiveRecord::Migration[5.0]
  def change
    add_column :email_preferences, :upvote_notifications, :boolean, default: :true
  end
end
