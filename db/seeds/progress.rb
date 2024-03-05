def generate_progresses
  progresses = ['Todo', 'Daily', 'In Progress', 'Completed']

  progresses.each do |progress|
    Progress.find_or_create_by!(name: progress)
  end
end