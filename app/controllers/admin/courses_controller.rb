# frozen_string_literal: true

module Admin
  class CoursesController < ApplicationController
    before_action :authenticate_user!
    before_action :admin?

    def index
      @courses = Course.all.order(updated_at: :desc)
    end

    def show
      @course = Course.friendly.find(params[:id])
    end

    def new
      @course = current_user.courses.build
    end

    def create
      @course = Course.new(course_params.merge(user: current_user))
      if @course.save
        redirect_to admin_courses_path, notice: "Course successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @course = Course.friendly.find(params[:id])
    end

    def update
      @course = Course.friendly.find(params[:id])

      if @course.update(course_params)
        redirect_to edit_admin_course_url(@course), notice: "Course successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @course = Course.friendly.find(params[:id])

      @course.destroy
      redirect_to admin_courses_ur, notice: "Course successfully deleted."
    end

    private

    def course_params
      params.require(:course).permit(%i[title slug description author url category impact])
    end
  end
end
