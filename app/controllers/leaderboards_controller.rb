# frozen_string_literal: true

class LeaderboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @skill_total_rankings = Leaderboard.rank_users_by_total_skill_score
    @total_impact_rankings = Leaderboard.rank_users_by_total_impact
    @skill_rankings_by_category = calculate_skill_rankings_by_category
    @category = 'total_skill'
  end

  private 

  def calculate_skill_rankings_by_category
    # Define an array of skill categories
    skill_categories = %i[management_skill technical_skill communication_skill
                          financial_skill analytical_skill work_ethics]
    skill_rankings_by_category = {}
    skill_categories.each do |category|
      skill_rankings_by_category[category] = Leaderboard.rank_users_by_skill_total_per_category(category)
    end
    skill_rankings_by_category
  end
end
