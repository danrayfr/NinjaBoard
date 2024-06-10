# frozen_string_literal: true

require "test_helper"

module Admin
  class RoleSkillMapsControllerTest < ActionDispatch::IntegrationTest
    def setup
      @role_skill_map = role_skill_maps(:one)
      @user = users(:admin)
    end

    test "should get index" do
      sign_in @user
      get admin_role_skill_maps_url
      assert_response :success
    end

    test "should get new" do
      sign_in @user
      get new_admin_role_skill_map_url
      assert_response :success
    end

    test "should create role skill map" do
      sign_in @user

      assert_difference "RoleSkillMap.count", 1 do
        post admin_role_skill_maps_url, params: { role_skill_map: { title: "sme" } }
      end
      assert_redirected_to admin_role_skill_maps_url
    end

    test "should get edit" do
      sign_in @user
      get edit_admin_role_skill_map_url(@role_skill_map)
      assert_response :success
    end

    test "should update the existing role skill map record" do
      sign_in @user

      assert_no_difference "RoleSkillMap.count" do
        patch admin_role_skill_map_url(@role_skill_map), params: {
          role_skill_map: {
            title: "technical manager"
          }
        }
      end
    end
  end
end
