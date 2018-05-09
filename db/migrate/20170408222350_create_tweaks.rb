class CreateTweaks < ActiveRecord::Migration[5.0]
  def change
    create_table :tweaks do |t|
      t.string :name
      t.references :title, foreign_key: true

      t.timestamps
    end
  end
end
