# frozen_string_literal: true

class Leaderboard < ApplicationRecord
  has_many :assigned_courses
  has_many :assessments, through: :user_assigned_courses
  has_many :user_skill_maps

  def self.rank_users_by_skill_total_per_category(skill_category)
    User.joins(:user_skill_map)
        .select("users.*, SUM(user_skill_maps.#{skill_category}) AS total_#{skill_category}_score")
        .group('users.id')
        .order("#{skill_category}_score DESC")
  end

  def self.rank_users_by_total_skill_score
    User.joins(:user_skill_map)
        .select('users.*, SUM(user_skill_maps.management_skill + user_skill_maps.technical_skill + user_skill_maps.communication_skill + user_skill_maps.financial_skill + user_skill_maps.analytical_skill + user_skill_maps.work_ethics) AS total_skill_score')
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
