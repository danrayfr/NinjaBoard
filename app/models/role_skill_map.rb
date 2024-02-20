class RoleSkillMap < ApplicationRecord
  validates :title, presence: true, uniqueness: true, length: { maximum: 50 }
end
