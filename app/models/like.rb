class Like < ApplicationRecord
  belongs_to :user
  belongs_to :description

  scope :unacknowledged, -> { where(acknowledged: false) }
end
