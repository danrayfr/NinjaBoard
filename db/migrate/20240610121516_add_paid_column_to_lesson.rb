class AddPaidColumnToLesson < ActiveRecord::Migration[7.1]
  def change
    add_column :lessons, :paid, :boolean, default: false
  end
end
