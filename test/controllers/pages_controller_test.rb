# frozen_string_literal: true

require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get home' do
    sign_in users(:ninja)

    get root_url
    assert_response :success
  end
end
