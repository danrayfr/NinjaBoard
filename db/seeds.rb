# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

require_relative 'seeds/course'
require_relative 'seeds/progress'
require_relative 'seeds/role_skill_map'
require_relative 'seeds/user'

create_users
generate_progresses
generate_role_maps
generate_courses
update_courses

User.find_each(&:build_user_skill_map_if_missing)

User.find_each(&:build_user_badge_if_missing)

Badge.find_each(&:create_level)

UserSkillMap.find_each(&:create_trophies_for_skills)

Trophy.find_each(&:create_level)
