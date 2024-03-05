# frozen_string_literal: true

# == Schema Information
#
# Table name: courses
#
# id                          :bigint                         not null, primary key
# assigned_course_id          :bigint                         not null
# user_skill_map_id           :bigint                         not null
#
# Indexes
#
# index_leaderboards_on_assigned_course_id                    (assigned_course_id)
# index_leaderboards_on_user_skill_map_id                     (user_skill_map_id)
#
# Foreign keys
#
# fk_rails ... (assign_course_id => assigned_course.id)
# fk_rails ... (user_skill_map_id => user_skill_map.id)
#

class Leaderboard < ApplicationRecord
  has_many :assigned_courses
  has_many :assessments, through: :user_assigned_courses
  has_many :user_skill_maps

  def self.rank_users_by_skill_total_per_category(skill_category)
    User.joins(:user_skill_map)
        .select("users.*, SUM(user_skill_maps.#{skill_category}) AS #{skill_category}_score")
        .group('users.id')
        .order("#{skill_category}_score DESC")
  end

  def self.rank_users_by_total_skill_score
    User.joins(:user_skill_map)
        .select('users.*, SUM(user_skill_maps.management_skill + user_skill_maps.technical_skill+ user_skill_maps.communication_skill + user_skill_maps.financial_skill +
        user_skill_maps.analytical_skill + user_skill_maps.work_ethics) AS total_skill_score')
        .group('users.id')
        .order('total_skill_score DESC')
  end

  def self.rank_users_by_total_impact
    User.joins(assigned_courses: :course)
        .select('users.*, SUM(courses.impact) AS total_impact')
        .group('users.id')
        .order('total_impact DESC')
  end
end
