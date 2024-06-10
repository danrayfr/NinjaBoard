# frozen_literal_string: true

class LessonsController < ApplicationController
  before_action :set_course
  before_action :set_lesson, only: %i[show update]
  before_action :check_paid

  def show
    @completed_lessons = current_user.user_lessons.where(completed: true).pluck(:lesson_id)
    @course = @lesson.course
    @paid_for_course = current_user.user_courses.where(course: @course).exists?
    puts "paid_for_course: #{@paid_for_course}"
  end

  def update
    @user_lesson = UserLesson.find_or_create_by(user: current_user, lesson: @lesson)
    @user_lesson.update!(completed: true)

    next_lesson = @course.lessons.where("position > ?", @lesson.position).order(:position).first

    if next_lesson
      redirect_to course_lesson_path(@course, next_lesson)
    else
      redirect_to course_path(@course), notice: "You have completed the course."
    end
  end

  private

  def set_course
    @course = Course.friendly.find params[:course_id]
  end

  def set_lesson
    @lesson = Lesson.find params[:id]
  end

  def lesson_params
    params.require(:lesson).permit(:title, :description, :paid, :course_id)
  end

  def check_paid
    if @lesson.paid && !current_user.user_courses.exists?(course_id: @course.id)
      if @lesson.previous_lesson
        redirect_to course_lesson_path(@course, @lesson.previous_lesson), notice: "You must purchase the full course to access the next lesson"
      else
        redirect_to course_path(@course), notice: "You must purchase the full course to access the next lesson"
      end
    end
  end
end
