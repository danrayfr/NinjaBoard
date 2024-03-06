def create_users
  puts('Creating users')
  admin = User.create!(email: 'ninjaboard-admin@gmail.com', password: '!MM3rs!v3', password_confirmation: '!MM3rs!v3', role: 'admin', username: 'Ninja Admin')

  moderator = User.create!(email: 'ninjaboard-moderator@gmail.com', password: '!MM3rs!v3', password_confirmation: '!MM3rs!v3', role: 'admin', username: 'Ninja Moderator')

  ninja = User.create!(email: 'ninja@gmail.com', password: '!MM3rs!v3', password_confirmation: '!MM3rs!v3', role: 'ninja', username: 'Ninja')

  master = User.create!(email: 'master@gmail.com', password: '!MM3rs!v3', password_confirmation: '!MM3rs!v3', role: 'ninja', username: 'master Ninja')

  sensei = User.create!(email: 'sensei@gmail.com', password: '!MM3rs!v3', password_confirmation: '!MM3rs!v3', role: 'ninja', username: 'Sensei Ninja')

  legend = User.create!(email: 'legend@gmail.com', password: '!MM3rs!v3', password_confirmation: '!MM3rs!v3', role: 'ninja', username: 'Legendary Ninja')

  puts('user created.')

  incerement_user_points(master, 24000)
  incerement_user_points(sensei, 41000)
  incerement_user_points(legend, 82000)
end

def incerement_user_points(user, points)
  user.badge.level.increment_points(points)
  user.badge.set_rank
end