# frozen_string_literal: true

class AssignedCourse < ApplicationRecord
  belongs_to :user
  belongs_to :course
  belongs_to :progress

  include RankedModel
  ranks :row_order, with_same: :progress_id

  enum progress_status: %i[todo daily in_progress completed]
  after_save :update_progress_status

  validate :unique_assignment_per_user_and_course, on: :create

  # Override the setter method for the progress association
  def progress=(value)
    if value.is_a?(Progress)
      super(value)
    else
      super(Progress.find_by(id: value) || Progress.find_by(name: 'Todo'))
    end
  end

  private

  def update_progress_status
    self.progress_status = case progress_id
                           when 1
                             :todo
                           when 2
                             :daily
                           when 3
                             :in_progress
                           when 4
                             :completed
                           end
    save if progress_status_changed?
  end

  def unique_assignment_per_user_and_course
    return unless AssignedCourse.exists?(user_id:, course_id:)

    errors.add(:base, 'You have already been assigned this course.')
  end
end
