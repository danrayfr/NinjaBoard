class RemovePublishedOnCourses < ActiveRecord::Migration[7.1]
  def change
    remove_column :courses, :published
  end
end
