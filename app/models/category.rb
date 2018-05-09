class Category < ApplicationRecord
  has_many :titles, dependent: :destroy

  rails_admin do
    exclude_fields :titles
  end
end
