def create_users
  puts('Creating users')
  User.create!(email: 'ninjaboard-admin@gmail.com', password: '!MM3rs!v3', password_confirmation: '!MM3rs!v3', role: 'admin', username: 'Ninja Admin')

  User.create!(email: 'ninjaboard-moderator@gmail.com', password: '!MM3rs!v3', password_confirmation: '!MM3rs!v3', role: 'admin', username: 'Ninja Moderator')
  puts('user created.')
end
