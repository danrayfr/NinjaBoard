require 'test_helper'

class CertificatesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:ninja)
    @certificate = certificates(:one)
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
        date_awarded: Time.now,
        file: fixture_file_upload('sample_certificate.png', 'image/png')
      } }
    end

    assert_redirected_to certificates_url
  end

  test 'Should get edit' do
    sign_in @user

    get edit_certificate_url(@certificate)
    assert_response :success
  end

  test 'should get update' do
    sign_in @user

    assert_no_difference 'Certificate.count' do
      patch certificate_url(@certificate), params: { certificate:
      {
        title: 'Core Value',
        date_awarded: Time.now,
        file: fixture_file_upload('sample_certificate.png', 'image/png')
      } }
    end

    assert_redirected_to certificates_url
  end

  test 'should get delete' do
    sign_in @user

    assert_difference 'Certificate.count', -1 do
      delete certificate_url(@certificate)
    end

    assert_redirected_to certificates_url
  end
end
