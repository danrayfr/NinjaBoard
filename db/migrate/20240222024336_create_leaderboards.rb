# frozen_string_literal: true

class CreateLeaderboards < ActiveRecord::Migration[7.1]
  def change
    create_table :leaderboards do |t|
      t.references :assigned_course, null: false, foreign_key: true
      t.references :user_skill_map, null: false, foreign_key: true
      # t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
