# frozen_string_literal: true

# == Schema Information
#
# Table name: trophies
#
# id                          :bigint                         not null, primary key
# name                        :string
# user_skill_map_id           :bigint                         not null
#
# Indexes
#
# index_trophies_on_user_skill_map_id                         (user_skill_map_id)
#
# Foreign keys
#
# fk_rails ... (user_skill_map_id => user_skill_map.id)
#

class Trophy < ApplicationRecord
  include BuildAssociation
  belongs_to :user_skill_map
  has_one :level, as: :levelable

  after_create :create_level

  def create_level
    build_association_if_missing(:level)
  end
end
