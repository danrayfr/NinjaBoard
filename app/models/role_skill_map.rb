# frozen_string_literal: true

# == Schema Information
#
# Table name: role_skill_maps
#
# id                          :bigint                         not null, primary key
# title                       :string
# description                 :string
# management_skill            :float                          default(0.0)
# technical_skill             :float                          default(0.0)
# communication_skill         :float                          default(0.0)
# financial_skill             :float                          default(0.0)
# analytical_skill            :float                          default(0.0)
# work_ethics                 :float                          default(0.0)
# slug                        :string
#
# Indexes
#
# index_role_skill_maps_on_slug                               (slug)
#

class RoleSkillMap < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  validates :title, presence: true, uniqueness: true, length: { maximum: 50 }
end
