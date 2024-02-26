class CreateBadges < ActiveRecord::Migration[7.1]
  def change
    create_table :badges do |t|
      t.integer :rank, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
