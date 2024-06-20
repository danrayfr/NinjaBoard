require "test_helper"

class AssignedCourseTest < ActiveSupport::TestCase
  def setup
    @user = users(:ninja)
    @course = courses(:unity)
    @assigned_course = AssignedCourse.new(user: @user, course: @course)
  end

  test "assigned course should be valid" do
    assert @assigned_course.valid?
  end
end
