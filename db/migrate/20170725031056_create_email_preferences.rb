class CreateEmailPreferences < ActiveRecord::Migration[5.0]
  def change
    create_table :email_preferences do |t|
      t.references :user, foreign_key: true
      t.boolean :wit_stop, default: true

      t.timestamps
    end
  end
end
