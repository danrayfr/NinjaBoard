class RemoveUserFromCourses < ActiveRecord::Migration[7.1]
  def change
    remove_reference :courses, :user, index: true, foreign_key: true
  end
end
