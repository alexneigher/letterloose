class AddCategoryToTitles < ActiveRecord::Migration[5.0]
  def change
    add_reference :titles, :category, index: true
  end
end
