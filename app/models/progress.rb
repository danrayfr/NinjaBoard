# frozen_string_literal: true

# == Schema Information
#
# Table name: progresses
#
# id                          :bigint                         not null, primary key
# name                        :string
# row_order                   :integer
#

class Progress < ApplicationRecord
  has_many :assigned_courses, dependent: :destroy
  validates :name, presence: true, uniqueness: true

  include RankedModel
  ranks :row_order
end
