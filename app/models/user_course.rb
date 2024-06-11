class UserCourse < ApplicationRecord
  belongs_to :user
  belongs_to :course
  belongs_to :progress

  include RankedModel
  ranks :row_order, with_same: :progress_id

  enum progress_status: %w[todo daily in_progress completed]
  after_save :update_progress_status

  validate :unique_assignment_per_user_and_course, on: :create
  after_update :update_user_skill_map_if_completed

  # Override the setter method for the progress association
  def progress=(value)
    if value.is_a?(Progress)
      super(value)
    else
      super(Progress.find_by(id: value) || Progress.find_by(name: "Todo"))
    end
  end

  def update_user_skill_map_if_completed
    return unless saved_change_to_progress_status? && progress_status == "completed"

    update_user_skill_map
  end

  private

  def update_progress_status
    status_mapping = {
      1 => :todo,
      2 => :daily,
      3 => :in_progress,
      4 => :completed
    }
    status = status_mapping[progress_id]
    self.progress_status = status if status
    save if progress_status_changed?
  end

  def unique_assignment_per_user_and_course
    return unless UserCourse.exists?(user_id:, course_id:)

    errors.add(:base, "You have already been assigned this course.")
  end

  def update_user_skill_map
    case course.category
    when "management"
      user.user_skill_map.increment!(:management_skill, course.impact)
      user.user_skill_map.trophies.find_by(name: "management_skill").level.increment_points(50)
    when "technical"
      user.user_skill_map.increment!(:technical_skill, course.impact)
      user.user_skill_map.trophies.find_by(name: "technical_skill").level.increment_points(50)
    when "communication"
      user.user_skill_map.increment!(:communication_skill, course.impact)
      user.user_skill_map.trophies.find_by(name: "communication_skill").level.increment_points(50)
    when "financial"
      user.user_skill_map.increment!(:financial_skill, course.impact)
      user.user_skill_map.trophies.find_by(name: "financial_skill").level.increment_points(50)
    when "analytical"
      user.user_skill_map.increment!(:analytical_skill, course.impact)
      user.user_skill_map.trophies.find_by(name: "analytical_skill").level.increment_points(50)
    when "work_ethics"
      user.user_skill_map.increment!(:work_ethics, course.impact)
      user.user_skill_map.trophies.find_by(name: "work_ethics").level.increment_points(50)
    end

    # Update date_completed if progress status is completed
    return unless progress_status == "completed"

    user.badge.level.increment_points(50)

    update(date_completed: Time.now)
  end

  def increment_and_update_trophy(skill)
    user_skill_map.increment!(skill, course.impact)
    trophy = user_skill_map.trophies.find_by(name: skill.to_s)
    trophy&.level&.increment_points(50)
  end
end
