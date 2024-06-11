class AddProgressReferencesToUserCourses < ActiveRecord::Migration[7.1]
  def up
    add_reference :user_courses, :progress, null: true, foreign_key: true

    default_progress_id = Progress.first&.id
    UserCourse.update_all(progress_id: default_progress_id)

    # Change the column to non-nullable
    change_column_null :user_courses, :progress_id, false
  end

  def down
    remove_reference :user_courses, :progress, foreign_key: true
  end
end
