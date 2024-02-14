require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  def setup
    @user = users(:moderator)

    @course = @user.courses.build(title: '5 Core Values', published: false)
  end

  test 'course should be valid' do
    assert @course.valid?
  end

  test 'course title should be present' do
    @course.title = ''
    assert_not @course.valid?
  end

  test 'course published is false by default' do
    course = @user.courses.build(title: '5 Core Values')
    course.save!

    assert_equal false, course.reload.published

    course = @user.courses.build(title: 'The Ninja Way')
    course.save!

    assert_not_equal true, course.reload.published
  end

  test 'slug is automatically created and downcased' do
    course = @user.courses.build(title: '5 Core Values', published: false)
    course.save!

    assert_equal '5-core-values', course.reload.slug

    course = @user.courses.build(title: 'The Ninja Way', published: false)
    course.save!

    assert_equal 'the-ninja-way', course.reload.slug
  end
end
