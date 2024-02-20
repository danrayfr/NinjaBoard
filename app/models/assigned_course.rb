# frozen_string_literal: true

class AssignedCourse < ApplicationRecord
  belongs_to :user
  belongs_to :course

  enum progress: %i[todo daily in_progress completed]

  # validates :course_id, uniqueness: { scope: :user_id, message: 'has already been assigned to this user' }

  private

  def assessment_score_present_if_completed
    # The assessment score & result if pass or fail should provided by the LMS
    errors.add(:assessment_score, "can't be blank") if assessment_score.blank?

    self.pass = assessment_score.pressent? ? 'pass' : 'fail'
  end

  def date_completed_allowed_if_progress_completed
    return unless date_completed.present? && progress != 'completed'

    errors.add(:date_completed, 'can only be set when progress is completed.')
  end
end
