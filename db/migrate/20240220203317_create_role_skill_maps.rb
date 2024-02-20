class CreateRoleSkillMaps < ActiveRecord::Migration[7.1]
  def change
    create_table :role_skill_maps do |t|
      t.string :title
      t.string :description
      t.float :management_skill, default: 0
      t.float :technical_skill, default: 0
      t.float :communication_skill, default: 0
      t.float :financial_skill, default: 0
      t.float :analytical_skill, default: 0
      t.float :work_ethics, default: 0

      t.timestamps
    end
  end
end
