class ChangePointsColumnTypesInLevels < ActiveRecord::Migration[7.1]
  def up
    change_column :levels, :points, :integer
  end

  def down
    change_column :levels, :points, :float
  end
end
