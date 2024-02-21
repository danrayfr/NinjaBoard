# frozen_string_literal: true

module Admin
  class RoleSkillMapsController < ApplicationController
    before_action :authenticate_user!
    before_action :admin?
    before_action :set_role_skill_map, only: %i[edit update destroy]

    def index
      @role_skill_maps = RoleSkillMap.all.order(updated_at: :desc)
    end

    def new
      @role_skill_map = RoleSkillMap.new
    end

    def create
      @role_skill_map = RoleSkillMap.new(skill_map_params)

      if @role_skill_map.save
        redirect_to admin_role_skill_maps_url, notice: 'Role skill map successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @role_skill_map.update(skill_map_params)
        redirect_to edit_admin_role_skill_map_url(@role_skill_map), notice: 'Role skill map successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      return unless @role_skill_map.destroy

      redirect_to admin_role_skill_maps_url, notice: 'Role skill map successfully deleted.'
    end

    private

    def set_role_skill_map
      @role_skill_map = RoleSkillMap.friendly.find(params[:id])
    end

    def skill_map_params
      params.require(:role_skill_map)
            .permit(:title, :description, :management_skill, :technical_skill,
                    :communication_skill, :financial_skill, :analytical_skill,
                    :work_ethics, :slug)
    end
  end
end
