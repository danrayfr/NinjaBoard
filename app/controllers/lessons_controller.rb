# frozen_literal_string: true

class LessonsController < ApplicationController
  prepend_before_action :authenticate_user!
  before_action :set_course
  before_action :set_lesson, only: %i[show update update_watch_duration]
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

  def update_watch_duration
    @user_lesson = UserLesson.find_or_create_by(user: current_user, lesson: @lesson)
    @user_lesson.update(watch_duration: params[:watch_duration])

    if @user_lesson.watch_duration >= 3 # required watch time in seconds
      @user_lesson.update(completed: true)
    end

    if @user_lesson.watch_duration >= @lesson.video.blob.metadata[:duration] - 1 # required watch time in seconds
      @user_lesson.update(completed: true)
      next_lesson = @user_lesson.lesson.next_lesson
      redirect_url = if next_lesson
                       course_lesson_path(@user_lesson.lesson.course, next_lesson)
                     else
                       course_path(@user_lesson.lesson.course)
                     end
      render json: { completed: true, redirect_url: redirect_url, notice: "You have completed the course." }
    else
      render json: { completed: false }
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
        redirect_to course_lesson_path(@course, @lesson.previous_lesson),
                    notice: "You must purchase the full course to access the next lesson"
      else
        redirect_to course_path(@course), notice: "You must purchase the full course to access the next lesson"
      end
    end
  end
end
