class UserLesson < ApplicationRecord
  belongs_to :lesson
  belongs_to :user

  validates :watch_duration, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
end
