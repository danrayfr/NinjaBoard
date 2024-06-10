class Lesson < ApplicationRecord
  acts_as_list

  belongs_to :course
  has_many :user_lessons, dependent: :destroy

  has_one_attached :video do |attachable|
    attachable.variant :thumb, resize_to_limit: [500, 500]
  end
  has_rich_text :description

  def next_lesson
    course.lessons.where("position > ?", position).order(:position).first
  end

  def previous_lesson
    course.lessons.where("position < ?", position).order(:position).last
  end
end
