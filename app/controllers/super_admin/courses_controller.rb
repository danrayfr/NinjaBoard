# app/controllers/super_admin/courses_controller.rb

class SuperAdmin::CoursesController < SuperAdminController
  before_action :set_course, only: %w[show edit update destroy]

  def index
    @super_admin_courses = Course.all.order(created_at: :desc)
  end

  def show; end

  def new
    @super_admin_course = Course.new
  end

  def create
    @super_admin_course = Course.new(course_params)

    if @super_admin_course.save
      redirect_to super_admin_courses_path, notice: "Successfully created the course."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @super_admin_course.update(course_params)
      redirect_to super_admin_courses_path, notice: "Successfully updated the course."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    redirect_to super_admin_courses_path, notice: "Course is successfully deleted" if @super_admin_course.destroy
  end

  private

  def set_course
    @super_admin_course = Course.friendly.find(params[:id])
  end

  def course_params
    params.require(:course)
          .permit(:title, :description, :slug, :author, :category, :impact,
                  :paid, :stripe_price_id, :premium_description, :image)
  end
end
