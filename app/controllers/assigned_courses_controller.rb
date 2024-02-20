# frozen_string_literal: true

class AssignedCoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    @assigned_courses = current_user.assigned_courses.order(updated_at: :desc)
  end

  def create
    @course = Course.find(params[:course_id])
    @assigned_course = AssignedCourse.new(user: current_user, course: @course)

    if @assigned_course.valid?
      @assigned_course.save
      redirect_to courses_path, notice: 'Course successfully assigned.'
    else
      redirect_to new_assigned_course_path, alert: @assigned_course.errors.full_messages.join(', ')
    end
  end

  private

  def set_assigned_course
    @assigned_course = AssignedCourse.find(params[:id])
  end

  def assigned_course_params
    params.require(:assigned_course)
          .permit(:user_id, :course_id, :pass, :assessment_score, :date_completed, :progress)
  end
end
