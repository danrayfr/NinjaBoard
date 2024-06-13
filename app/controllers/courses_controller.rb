class CoursesController < ApplicationController
  prepend_before_action :authenticate_user!
  before_action :set_course, only: :show

  def index
    @courses = Course.all
    @user_unlocked_courses = current_user&.user_courses&.pluck(:course_id)
    @user_started_courses = current_user&.user_lessons&.joins(:lesson)&.pluck(:course_id)&.uniq
    if @user_started_courses.present?
      @user_course_progresses = @user_started_courses.map do |course_id|
        course_lessons = Course.find(course_id).lessons.count
        completed_lessons = current_user&.user_lessons&.joins(:lesson)&.where(completed: true, lesson: { course: course_id })&.count
        { course_id: course_id, completed_percentage: (completed_lessons.to_f / course_lessons.to_f * 100).to_i }
      end
    end
  end

  def show
    @completed_lessons = current_user&.user_lessons&.joins(:lesson)&.where(completed: true, lesson: { course: @course })&.pluck(:lesson_id)
    @user_unlocked_course = current_user&.user_courses&.where(course: @course)&.exists?
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to course_url(@course), notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_course
    @course = Course.friendly.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description)
  end

  def courses_per_category
    # Group courses by category
    categories = {}
    @courses.each do |course|
      category = course.category
      categories[category] ||= []
      categories[category] << course
    end

    categories
  end
end
