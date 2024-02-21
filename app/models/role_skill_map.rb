class RoleSkillMap < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  validates :title, presence: true, uniqueness: true, length: { maximum: 50 }
end
