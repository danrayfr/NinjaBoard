class CreateAssignedCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :assigned_courses do |t|
      t.boolean :pass, null: false, default: false
      t.float :assessment_score
      t.datetime :date_completed
      t.integer :progress, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
