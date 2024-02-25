require 'test_helper'

class CertificatesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:ninja)
  end

  test 'should get index' do
    sign_in @user
    get certificates_url
    assert_response :success
  end

  test 'should get new' do
    sign_in @user
    get new_certificate_url
    assert_response :success
  end

  test 'Should create new certificate' do
    sign_in @user

    assert_difference 'Certificate.count', 1 do
      post certificates_url, params: { certificate:
      {
        title: 'The Ninja Way',
        date_awarded: Time.now
      } }
    end

    assert_redirected_to certificates_url
  end
end
