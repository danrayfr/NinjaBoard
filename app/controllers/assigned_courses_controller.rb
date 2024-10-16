# frozen_string_literal: true

class AssignedCoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_assigned_course, only: :sort

  def index
    @assigned_courses = current_user.assigned_courses.rank :row_order
  end

  def new; end

  def create
    @course = Course.friendly.find(params[:course_id])

    # Default progress is todo when getting the course by user itself.
    default_progress = Progress.find_by(name: "Todo")

    @assigned_course = AssignedCourse.new(user: current_user, course: @course, progress: default_progress)

    if @assigned_course.valid?
      @assigned_course.save
      redirect_to courses_path, notice: "Course successfully assigned."
    else
      redirect_to new_assigned_course_path, alert: @assigned_course.errors.full_messages.join(", ")
    end
  end

  def sort
    @assigned_course = AssignedCourse.find(params[:id])
    @assigned_course.update(row_order_position: params[:row_order_position], progress_id: params[:progress_id])

    head :no_content
  end

  private

  def set_assigned_course
    @assigned_course = AssignedCourse.find params[:id]
  end

  def assigned_course_params
    params.require(:assigned_course)
          .permit(:user_id, :course_id, :progress_id, :pass,
                  :assessment_score, :date_completed, :progress)
  end
end
