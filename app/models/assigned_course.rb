# frozen_string_literal: true

class AssignedCourse < ApplicationRecord
  belongs_to :user
  belongs_to :course

  enum progress: %i[todo daily in_progress completed]

  validate :unique_assignment_per_user_and_course

  private

  def unique_assignment_per_user_and_course
    return unless AssignedCourse.exists?(user_id:, course_id:)

    errors.add(:base, 'You have already been assigned this course.')
  end
end
