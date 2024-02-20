class RenameProgressColumnInAssignedCourses < ActiveRecord::Migration[7.1]
  def change
    rename_column :assigned_courses, :progress, :progress_status
  end
end
