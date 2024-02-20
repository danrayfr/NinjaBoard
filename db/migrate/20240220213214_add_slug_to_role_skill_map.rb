class AddSlugToRoleSkillMap < ActiveRecord::Migration[7.1]
  def change
    add_column :role_skill_maps, :slug, :string
    add_index :role_skill_maps, :slug, unique: true
  end
end
