# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

# create_users

def create_users
  puts("Creating users")
  User.create!(email: "ninjaboard-admin@gmail.com", password: "password", password_confirmation: "password",
               role: "admin", username: "Ninja Admin")

  User.create!(email: "ninjaboard-moderator@gmail.com", password: "password",
               password_confirmation: "password", role: "admin", username: "Ninja Moderator")

  User.create!(email: "ninja@gmail.com", password: "password", password_confirmation: "password", role: "ninja", username: "Ninja")

  master = User.create!(email: "master@gmail.com", password: "password", password_confirmation: "password",
                        role: "ninja", username: "master Ninja")

  sensei = User.create!(email: "sensei@gmail.com", password: "password", password_confirmation: "password",
                        role: "ninja", username: "Sensei Ninja")

  legend = User.create!(email: "legend@gmail.com", password: "password", password_confirmation: "password",
                        role: "ninja", username: "Legendary Ninja")

  puts("user created.")

  incerement_user_points(master, 24_000)
  incerement_user_points(sensei, 41_000)
  incerement_user_points(legend, 82_000)
end

def incerement_user_points(user, points)
  user.badge.level.increment_points(points)
  user.badge.set_rank
end

# generate_progresses

def generate_progresses
  progresses = ["Todo", "Daily", "In Progress", "Completed"]

  progresses.each do |progress|
    Progress.find_or_create_by!(name: progress)
  end
end

# generate_role_maps

def generate_role_maps
  roles = role_collection

  roles.each do |role|
    RoleSkillMap.find_or_create_by!(
      title: role[:title],
      description: role[:description],
      management_skill: role[:management_skill],
      technical_skill: role[:technical_skill],
      communication_skill: role[:communication_skill],
      financial_skill: role[:financial_skill],
      analytical_skill: role[:analytical_skill],
      work_ethics: role[:work_ethics]
    )
  end

  puts("Done creating role skill maps")
end

def role_collection
  [
    {
      title: "Operations Manager",
      description: "This new opening will handle accounts that are related to software development API support.",
      management_skill: 8.0,
      technical_skill: 8.0,
      communication_skill: 8.0,
      financial_skill: 8.0,
      analytical_skill: 10.0,
      work_ethics: 10.0
    },
    {
      title: "Subject Matter Expert(SME)",
      description: "The following are the minimum requirements for the SME opening.",
      management_skill: 6.0,
      technical_skill: 6.0,
      communication_skill: 6.0,
      financial_skill: 6.0,
      analytical_skill: 6.0,
      work_ethics: 10.0
    },
    {
      title: "Technical Manager",
      description: "The following are the minimum requirements for the SME opening.",
      management_skill: 7.0,
      technical_skill: 8.0,
      communication_skill: 7.0,
      financial_skill: 8.0,
      analytical_skill: 8.0,
      work_ethics: 10.0
    }
  ]
end

# generate_courses

def generate_courses
  courses = course_collection
  user = User.find_by(email: "ninjaboard-admin@gmail.com")

  courses.each do |course|
    Course.create(
      title: course[:title],
      description: Faker::Lorem.sentence,
      author: course[:author],
      category: course[:category],
      impact: impacts.sample,
      user:
    )
  end

  puts("Done creating courses data")
end

def update_courses
  puts("Updating courses url")
  Course.all.each do |course|
    course.update(url: "https://ninjaboard.com/course/#{course.slug}")
  end
end

def course_collection
  [
    { title: "Tell NELi roadshow", category: "work_ethics", author: "John Dave Cabiling" },
    { title: "Tell NELi (Ninja Ethics Line)", category: "work_ethics", author: "John Dave Cabiling" },
    { title: "Security Awareness Fundamentals", category: "technical", author: "John Dave Cabiling" },
    { title: "Occupational Safety and Health", category: "work_ethics", author: "Robby Manoy" },
    { title: "The Ninja MasterClass Episode 1", category: "management", author: "John Dave Cabiling" },
    { title: "Phrasal Verbs Part 1", category: "communication", author: "John Dave Cabiling" },
    { title: "Parts of Speech", category: "communication", author: "Robby Manoy" },
    { title: "Verb Tenses", category: "communication", author: "John Dave Cabiling" },
    { title: "Positive Scripting", category: "communication", author: "Bernadette Guinto" },
    { title: "Business Operation Plan", category: "management", author: "Timothy Kwok" },
    { title: "Bard AI Prompt Engineering Guide", category: "technical", author: "Timothy Kwok" },
    { title: "Windows Networking", category: "technical", author: "Timothy Kwok" },
    { title: "Tech Solutions Call Flow", category: "technical", author: "Timothy Kwok" },
    { title: "Mac Computer Training", category: "technical", author: "Timothy Kwok" },
    { title: "Handling Common Breakfix Issues", category: "analytical", author: "Timothy Kwok" },
    { title: "The Art of Control", category: "analytical", author: "Timothy Kwok" },
    { title: "Troubleshooting Methodology", category: "analytical", author: "Timothy Kwok" },
    { title: "4 Mental Exercises to Improve Your Time Management", category: "management",
      author: "Bernadette Guinto" },
    { title: "3 Leadership skills you should never compromise", category: "management", author: "Robby Manoy" },
    { title: "Account Assessment 1", category: "financial", author: "Shirley Lunar" }
  ]
end

def impacts
  [
    0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0,
    1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0
  ]
end

# update_courses
#

create_users
incerement_user_points
generate_progresses
generate_role_maps
generate_courses


User.find_each(&:build_user_skill_map_if_missing)

User.find_each(&:build_user_badge_if_missing)

Badge.find_each(&:create_level)

UserSkillMap.find_each(&:create_trophies_for_skills)

Trophy.find_each(&:create_level)
