class Certificate < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, uniqueness: true, length: { maximum: 100 }
  enum source: %i[default linkedin udemy coursera]
  validates :date_awarded, presence: true
end
