class CreateLessons < ActiveRecord::Migration[7.1]
  def change
    create_table :lessons do |t|
      t.string :title
      t.references :course, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
