class AddRowOrderToProgressAndAssignedCourse < ActiveRecord::Migration[7.1]
  def change
    add_column :progresses, :row_order, :integer
    add_column :assigned_courses, :row_order, :integer
  end
end
