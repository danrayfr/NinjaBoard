require "test_helper"

class CourseTest < ActiveSupport::TestCase
  def setup
    @user = users(:admin)

    @course = @user.courses.build(title: "5 Core Values", category: "work_ethics", impact: 0.5)
  end

  test "course should be valid" do
    assert @course.valid?
  end

  test "course title should be present" do
    @course.title = ""
    assert_not @course.valid?
  end

  test "course catalog title should not be greater than 50 characters" do
    @course.title = "a" * 51
    assert_not @course.valid?
  end

  test "course catalog title should be unique" do
    duplicate_catalog = @course.dup
    @course.save
    assert_not duplicate_catalog.valid?
  end

  test "courses catalog impact should be greater than or equal to 0" do
    @course.impact = -1
    assert_not @course.valid?
  end

  test "courses catalog impact should be less than or equal to 100" do
    @course.impact = 101
    assert_not @course.valid?
  end

  # test 'course published is false by default' do
  #   course = @user.courses.build(title: '5 Core Values')
  #   course.save!
  #   assert_equal false, course.reload.published
  #   course = @user.courses.build(title: 'The Ninja Way')
  #   course.save!
  #   assert_not_equal true, course.reload.published
  # end

  # test 'slug is automatically created and downcased' do
  #   course = @user.courses.build(title: '5 Core Values', published: false)
  #   course.save!
  #   assert_equal '5-core-values', course.reload.slug
  #   course = @user.courses.build(title: 'The Ninja Way', published: false)
  #   course.save!
  #   assert_equal 'the-ninja-way', course.reload.slug
  # end
end
