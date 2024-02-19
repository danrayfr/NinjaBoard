# frozen_string_literal: true

require 'test_helper'

module Admin
  class CoursesControllerTest < ActionDispatch::IntegrationTest
    def setup
      @course = courses(:leadership)
    end

    test 'should get index' do
      sign_in users(:admin)
      get admin_courses_url
      assert_response :success
    end

    test 'should get new' do
      sign_in users(:admin)
      get new_admin_course_url
      assert_response :success
    end

    test 'should create course' do
      sign_in users(:admin)

      assert_difference('Course.count', 1) do
        post admin_courses_url, params: { course: {
          title: 'The Ninja Way', slug: 'the-ninja-way'
        } }
      end

      assert_redirected_to admin_courses_url
    end

    test 'should get edit' do
      sign_in users(:admin)
      get edit_admin_course_url(@course)
      assert_response :success
    end

    test 'should update the existing course record' do
      sign_in users(:admin)

      assert_no_difference('Course.count') do
        patch admin_course_url(@course), params: {
          course: {
            title: 'Updated record',
            slug: 'updated-record'
          }
        }
      end
      assert_redirected_to edit_admin_course_url(@course.reload.slug)
    end
  end
end
