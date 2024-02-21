class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @role_skill_maps = RoleSkillMap.all
  end
end
