class AddProgressReferenceToAssignCourse < ActiveRecord::Migration[7.1]
  def change
    add_reference :assigned_courses, :progress, foreign_key: true
  end
end
