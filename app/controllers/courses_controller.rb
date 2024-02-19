class CoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    @courses = Course.all.order(updated_at: :desc)
  end

  def show
    @course = Course.friendly.find(params[:id])
  end
end
