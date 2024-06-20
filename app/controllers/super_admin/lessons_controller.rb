# app/controllers/super_admin/lessons_controller.rb

class SuperAdmin::LessonsController < SuperAdminController
  before_action :set_course
  before_action :set_lesson, only: %w[show move edit update destroy]

  def index
    @super_admin_lessons = @super_admin_course.lessons.order(:position)
  end

  def show; end

  def new
    @super_admin_lesson = @super_admin_course.lessons.build
  end

  def create
    @super_admin_lesson = @super_admin_course.lessons.build(lesson_params)

    if @super_admin_lesson.save
      redirect_to super_admin_course_lessons_path(@super_admin_course), notice: "New lesson is Successfully added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @super_admin_lesson.update(lesson_params)
      redirect_to super_admin_course_lessons_path(@super_admin_course), notice: "Lesson is successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @super_admin_lesson.destroy
      redirect_to super_admin_course_lessons_path(@super_admin_course), notice: "Lesson is successfully deleted."
    end
  end

  def move
    position = params[:position].to_i
    if position == 0
      @super_admin_lesson.move_to_top
    elsif position == @super_admin_course.lessons.count - 1
      @super_admin_lesson.move_to_bottom
    else
      @super_admin_lesson.insert_at(position + 1)
    end

    @super_admin_lesson.save!

    render json: { message: "success" }
  end

  private

  def set_course
    @super_admin_course = Course.friendly.find(params[:course_id])
  end

  def set_lesson
    @super_admin_lesson = Lesson.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :description, :video, :paid, :position)
  end
end
