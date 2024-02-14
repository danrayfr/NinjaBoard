# frozen_string_literal: true

require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @course = courses(:leadership)
  end

  test 'should get index' do
    sign_in users(:ninja)
    get courses_url
    assert_response :success
  end

  test 'should get new' do
    sign_in users(:ninja)
    get new_course_url
    assert_response :success
  end

  test 'should create course' do
    sign_in users(:ninja)

    assert_difference('Course.count', 1) do
      post courses_url, params: { course: {
        title: 'The Ninja Way', slug: 'the-ninja-way'
      } }
    end

    assert_redirected_to courses_url
  end

  test 'should get edit' do
    sign_in users(:ninja)
    get edit_course_url(@course)
    assert_response :success
  end

  test 'should update the existing course record' do
    sign_in users(:ninja)

    assert_no_difference('Course.count') do
      patch course_url(@course), params: {
        course: {
          title: 'Updated record',
          slug: 'updated-record'
        }
      }
    end
    assert_redirected_to edit_course_url(@course.reload.slug)
  end
end
