class AddColumnsToUserCourses < ActiveRecord::Migration[7.1]
  def change
    add_column :user_courses, :date_completed, :datetime
    add_column :user_courses, :row_order, :integer
    add_column :user_courses, :progress_status, :integer, default: 0
  end
end
