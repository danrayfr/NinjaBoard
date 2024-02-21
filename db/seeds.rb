# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# User.create(email: 'danrayrollan98@gmail.com', password: '!MM3rs!v3', password_confirmation: '!MM3rs!v3', role: 'admin')

# User.create(email: 'ninjaboard-admin@supportninja.com', password: 'P@ssword12345!', password_confirmation: 'P@ssword12345!', role: 'admin')

# Progress.create(name: 'Todo')
# Progress.create(name: 'Daily')
# Progress.create(name: 'In Progress')
# Progress.create(name: 'Completed')

User.find_each do |user|
  user.build_user_skill_map_if_missing
end
