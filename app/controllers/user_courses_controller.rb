# frozen_string_literal: true

class UserCoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_course, only: :sort

  def index
    @user_courses = current_user.user_courses.rank :row_order
  end

  def new; end

  def create
    @course = Course.friendly.find(params[:course_id])

    # Default progress is todo when getting the course by user itself.
    default_progress = Progress.find_by(name: "Todo")

    @user_course = UserCourse.new(user: current_user, course: @course, progress: default_progress)

    if @user_course.valid?
      @user_course.save
      redirect_to courses_path, notice: "Course successfully assigned."
    else
      redirect_to new_user_course_path, alert: @user_course.errors.full_messages.join(", ")
    end
  end

  def sort
    @user_course = UserCourse.find params[:id]
    @user_course.update(row_order_position: params[:row_order_position], progress_id: params[:progress_id])

    head :no_content
  end

  private

  def set_user_course
    @user_course = UserCourse.find params[:id]
  end

  def user_course_params
    params.require(:user_course)
          .permit(:user_id, :course_id, :progress_id,
                  :date_completed, :progress)
  end
end
