# frozen_string_literal: true

# == Schema Information
#
# Table name: courses
#
# id                          :bigint                         not null, primary key
# title                       :string
# slug                        :string
# author                      :string
# url                         :string
# category                    :integer                        default(0)
# impact                      :float                          default(0.0)
#
# Indexes
#
# index_courses_on_slug                                       (slug)
# index_courses_on_user_id                                    (user_id)
#
# Foreign keys
# fk_rails ... (slug => slug)
# fk_rails ... (user_id => user.id)
#

class Course < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :assigned_courses, dependent: :destroy

  has_rich_text :description
  has_one_attached :image do |attachable|
    attachable.variant :thum, resize_to_limit: [100, 100]
  end

  validates :title, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :impact, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10, allow_float: true }
  enum category: %w[management technical communication financial analytical work_ethics]

  def draft?
    !published?
  end
end
