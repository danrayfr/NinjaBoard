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

  puts('Done creating role skill maps')
end

def role_collection
  [
    {
      title: 'Operations Manager',
      description: 'This new opening will handle accounts that are related to software development API support.',
      management_skill: 8.0,
      technical_skill: 8.0,
      communication_skill: 8.0,
      financial_skill: 8.0,
      analytical_skill: 10.0,
      work_ethics: 10.0
    },
    {
      title: 'Subject Matter Expert(SME)',
      description: 'The following are the minimum requirements for the SME opening.',
      management_skill: 6.0,
      technical_skill: 6.0,
      communication_skill: 6.0,
      financial_skill: 6.0,
      analytical_skill: 6.0,
      work_ethics: 10.0
    },
    {
      title: 'Technical Manager',
      description: 'The following are the minimum requirements for the SME opening.',
      management_skill: 7.0,
      technical_skill: 8.0,
      communication_skill: 7.0,
      financial_skill: 8.0,
      analytical_skill: 8.0,
      work_ethics: 10.0
    }
  ]
end
