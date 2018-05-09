class CreateDescriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :descriptions do |t|
      t.text :text
      t.references :tweak, foreign_key: true
      t.integer :upvotes, default: 0
      t.integer :downvotes, default: 0
      t.timestamps
    end
  end
end
