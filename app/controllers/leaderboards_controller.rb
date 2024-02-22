# frozen_string_literal: true

class LeaderboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @skill_total_rankings = Leaderboard.rank_users_by_total_skill_score
    @total_impact_rankings = Leaderboard.rank_users_by_total_impact

    @skill_per_management = Leaderboard.rank_users_by_skill_total_per_category(:management_skill)
    @skill_per_technical = Leaderboard.rank_users_by_skill_total_per_category(:technical_skill)
    @skill_per_communication = Leaderboard.rank_users_by_skill_total_per_category(:communication_skill)
    @skill_per_financial = Leaderboard.rank_users_by_skill_total_per_category(:financial_skill)
    @skill_per_analytical = Leaderboard.rank_users_by_skill_total_per_category(:analytical_skill)
    @skill_per_work_ethics = Leaderboard.rank_users_by_skill_total_per_category(:work_ethics)
  end
end
