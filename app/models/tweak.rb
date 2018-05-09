class Tweak < ApplicationRecord
  belongs_to :title
  belongs_to :user
  has_many :descriptions, dependent: :destroy

  validates_uniqueness_of :name
end
