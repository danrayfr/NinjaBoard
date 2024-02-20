class Progress < ApplicationRecord
  has_many :assigned_courses, dependent: :destroy
  validates :name, presence: true

  include RankedModel
  ranks :row_order
end
