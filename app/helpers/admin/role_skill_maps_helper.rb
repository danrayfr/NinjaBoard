module Admin::RoleSkillMapsHelper
  def format_skill_progress(skill_value)
    # Limit the skill value to a maximum of 10
    [skill_value, 10].min * 10
  end
end
