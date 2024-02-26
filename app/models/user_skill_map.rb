# frozen_string_literal: true

class UserSkillMap < ApplicationRecord
  belongs_to :user
  has_many :trophies, dependent: :destroy

  after_commit :create_trophies_for_skills, on: :create

  def create_trophies_for_skills
    attributes.except('id', 'user_id', 'created_at', 'updated_at').each_key do |skill|
      Trophy.create(name: skill, user_skill_map: self)

      break if skill == 'work_ethics' # Stop creating trophies after 'work_ethics'
    end
  end
end
