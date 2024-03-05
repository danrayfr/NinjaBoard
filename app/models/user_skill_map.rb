# frozen_string_literal: true

# == Schema Information
#
# Table name: user_skill_maps
#
# id                          :bigint                         not null, primary key
# management_skill            :float                          default(0.0)
# technical_skill             :float                          default(0.0)
# communication_skill         :float                          default(0.0)
# financial_skill             :float                          default(0.0)
# analytical_skill            :float                          default(0.0)
# work_ethics                 :float                          default(0.0)
# user_id                     :bigint                         not null
#
# Indexes
#
# index_user_skill_maps_on_user_id                            (user_id)
#
# Foreign key
#
# fk_rails ... (user_id => user.id)
#

class UserSkillMap < ApplicationRecord
  belongs_to :user
  has_many :trophies, dependent: :destroy

  after_commit :create_trophies_for_skills, on: :create

  def create_trophies_for_skills
    return unless trophies.empty?

    attributes.except('id', 'user_id', 'created_at', 'updated_at').each_key do |skill|
      Trophy.create(name: skill, user_skill_map: self)

      break if skill == 'work_ethics' # Stop creating trophies after 'work_ethics'
    end
  end
end
