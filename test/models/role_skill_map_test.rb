require 'test_helper'

class RoleSkillMapTest < ActiveSupport::TestCase
  def setup
    @role_skill_map = RoleSkillMap.new(title: 'SME')
  end

  test 'Role skill map should be valid' do
    assert @role_skill_map.valid?
  end

  test 'title should be present' do
    @role_skill_map.title = ''
    assert_not @role_skill_map.valid?
  end

  test 'title should not be greater than 50 characters' do
    @role_skill_map.title = 'a' * 51
    assert_not @role_skill_map.valid?
  end
end
