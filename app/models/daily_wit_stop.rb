class DailyWitStop < ApplicationRecord
  
  belongs_to :description
  belongs_to :user

  scope :scheduled, -> { where(sent: false) }
  scope :sent, -> { where(sent: true) }

  validate :only_one_per_day, on: :create


  private
    def only_one_per_day
      wit_stops = DailyWitStop.scheduled.any?
      if wit_stops
        errors.add(:created_at, "Cannot schedule more than 1 per day")
      end
    end
end
