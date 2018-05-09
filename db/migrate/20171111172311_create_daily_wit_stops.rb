class CreateDailyWitStops < ActiveRecord::Migration[5.0]
  def change
    create_table :daily_wit_stops do |t|
      t.references :description, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :sent, default: :false
      t.datetime :sent_at
      
      t.timestamps
    end
  end
end
