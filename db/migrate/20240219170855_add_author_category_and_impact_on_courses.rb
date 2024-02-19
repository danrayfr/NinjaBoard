class AddAuthorCategoryAndImpactOnCourses < ActiveRecord::Migration[7.1]
  def change
    add_column :courses, :author, :string
    add_column :courses, :url, :string
    add_column :courses, :category, :integer, default: 0
    add_column :courses, :impact, :float, default: 0
  end
end
