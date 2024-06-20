class SuperAdminController < ApplicationController
  prepend_before_action :authenticate_super_admin!

  def index
    @stats = {
      sign_ups: User.where("created_at > ?", 1.week.ago).count,
      sales: UserCourse.where("created_at > ?", 1.week.ago).count,
      completed_lessons: UserLesson.where("created_at > ?", 1.week.ago).where(completed: true).count,
      total_sign_ups: User.count
    }

    @completed_lessons_by_day = UserLesson.where("created_at > ?", 1.week.ago).where(completed: true).group_by_day(:created_at, format: "%A").count

    @sign_ups_by_day = User.where("created_at > ?", 1.week.ago).group_by_day(:created_at, format: "%A").count

    @most_popular_courses = Course.joins(:user_courses).group(:id).order('count(user_courses.id) desc').limit(5)
  end
end
