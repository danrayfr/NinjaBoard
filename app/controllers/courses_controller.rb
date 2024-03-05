class CoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    @courses = Course.all.order(updated_at: :desc)
    @courses_by_category = courses_per_category
  end

  def show
    @course = Course.friendly.find(params[:id])
  end

  private

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
