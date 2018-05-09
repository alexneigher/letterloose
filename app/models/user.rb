class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username, presence: true

  has_many :titles
  has_many :tweaks
  has_many :likes
  has_many :descriptions
  has_one :email_preferences

  after_create do
    create_email_preferences
  end
end
