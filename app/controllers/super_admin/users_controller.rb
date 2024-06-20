# app/controllers/super_admin/users_controller.rb

class SuperAdmin::UsersController < SuperAdminController
  before_action :set_query_params, only: :index
  before_action :set_user, only: %w[show destroy]

  def index
    @super_admin_users = User.all.order(updated_at: :desc, created_at: :desc) unless @query.present?

    @super_admin_users = User.where("email LIKE ?", "%#{@query}%").order(updated_at: :desc, created_at: :desc)
  end

  def show
    @user_courses = fetch_user_courses(@super_admin_user)
    @user_course_progresses = calculate_course_progresses(@super_admin_user)
  end

  def destroy
    if @super_admin_user.destroy
      redirect_to super_admin_users_path, notice: "User was successfully destroyed."
    else
      redirect_to super_admin_users_path, alert: "Failed to destroy the user."
    end
  end

  private

  def set_user
    @super_admin_user = User.find(params[:id])
  end

  def set_query_params
    @query = params[:query]
  end

  def fetch_user_courses(user)
    course_ids = user.user_lessons.joins(:lesson).pluck(:course_id).uniq
    Course.where(id: course_ids)
  end

  def calculate_course_progresses(user)
    fetch_user_courses(user).map do |course|
      course_lessons_count = course.lessons.count
      completed_lessons_count = user.user_lessons.joins(:lesson).where(completed: true,
                                                                        lesson: { course: }).count

      completed_percentage = if course_lessons_count.zero?
                                0
                              else
                                (completed_lessons_count.to_f / course_lessons_count * 100).to_i
                              end

      { course_id: course.id, completed_percentage: }
    end
  end
end
