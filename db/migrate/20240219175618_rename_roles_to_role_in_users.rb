class RenameRolesToRoleInUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :roles, :role
  end
end
