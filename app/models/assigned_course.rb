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

  after_update :update_user_skill_map_if_completed

  # Override the setter method for the progress association
  def progress=(value)
    if value.is_a?(Progress)
      super(value)
    else
      super(Progress.find_by(id: value) || Progress.find_by(name: 'Todo'))
    end
  end

  def update_user_skill_map_if_completed
    if saved_change_to_progress_status? && progress_status == 'completed'
      update_user_skill_map
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

  def update_user_skill_map
    case course.category
    when 'management'
      user.user_skill_map.increment!(:management_skill, course.impact)
    when 'technical'
      user.user_skill_map.increment!(:technical_skill, course.impact)
    when 'communication'
      user.user_skill_map.increment!(:communication_skill, course.impact)
    when 'financial'
      user.user_skill_map.increment!(:financial_skill, course.impact)
    when 'analytical'
      user.user_skill_map.increment!(:analytical_skill, course.impact)
    when 'work_ethics'
      user.user_skill_map.increment!(:work_ethics, course.impact)
    end
  end
end
