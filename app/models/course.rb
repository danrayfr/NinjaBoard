class Course < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :user
  has_many :assigned_courses, dependent: :destroy

  has_rich_text :description

  validates :title, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :impact, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10, allow_float: true }
  enum category: %i[management technical communication financial analytical work_ethics]

  def draft?
    !published?
  end
end
