# frozen_string_literal: true

class Trophy < ApplicationRecord
  include BuildAssociation
  belongs_to :user_skill_map
  has_one :level, as: :levelable

  after_create :create_level

  def create_level
    build_association_if_missing(:level)
  end
end
