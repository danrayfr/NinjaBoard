class CreateLevels < ActiveRecord::Migration[7.1]
  def change
    create_table :levels do |t|
      t.integer :lvl, default: 1
      t.float :points, default: 0
      t.references :levelable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
