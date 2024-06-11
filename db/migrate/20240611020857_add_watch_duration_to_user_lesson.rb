class AddWatchDurationToUserLesson < ActiveRecord::Migration[7.1]
  def change
    add_column :user_lessons, :watch_duration, :integer
  end
end
