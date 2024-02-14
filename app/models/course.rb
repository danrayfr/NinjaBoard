class Course < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :user
  has_rich_text :description

  validates :title, presence: true, uniqueness: true, length: { maximum: 50 }

  def draft?
    !published?
  end
end
