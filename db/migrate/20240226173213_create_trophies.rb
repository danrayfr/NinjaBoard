class CreateTrophies < ActiveRecord::Migration[7.1]
  def change
    create_table :trophies do |t|
      t.string :name
      t.references :user_skill_map, null: false, foreign_key: true

      t.timestamps
    end
  end
end
