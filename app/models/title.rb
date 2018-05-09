class Title < ApplicationRecord
  has_many :tweaks, dependent: :destroy
  belongs_to :category
  belongs_to :user

  validates_presence_of :name
  validates_uniqueness_of :name
end
