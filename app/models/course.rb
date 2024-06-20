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

  has_many :lessons, dependent: :destroy
  has_many :assigned_courses, dependent: :destroy
  has_many :user_courses, dependent: :destroy

  has_rich_text :description
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end

  validates :title, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :impact, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10, allow_float: true }
  enum category: %w[management technical communication financial analytical work_ethics]

  def draft?
    !published?
  end

  def first_lesson
    lessons.order(:position).first
  end

  def next_lesson(current_user)
    return lessons.order(:position).first if current_user.blank?

    completed_lessons = current_user.user_lessons.includes(:lesson).where(completed: true).where(lessons: { course_id: id })
    started_lessons = current_user.user_lessons.includes(:lesson).where(completed: false).where(lesson: { course_id: id }).order(:position)

    return started_lessons.first.lesson if started_lessons.any?

    lessons = self.lessons.where.not(id: completed_lessons.pluck(:lesson_id)).order(:position)
    return self.lessons.order(:positon).first unless lessons.any?

    lessons.first
  end
end
