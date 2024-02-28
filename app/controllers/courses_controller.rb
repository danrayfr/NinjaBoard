class CoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    @courses = Course.all.order(updated_at: :desc)
    @courses_by_category = {}

    # Group courses by category
    Course.all.each do |course|
      category = course.category
      @courses_by_category[category] ||= []
      @courses_by_category[category] << course
    end
  end

  def show
    @course = Course.friendly.find(params[:id])
  end
end
