class CreateUserCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :user_courses do |t|
      t.references :course, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
