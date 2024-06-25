require "application_system_test_case"

class LoginsTest < ApplicationSystemTestCase
  setup do
    @login = logins(:one)
  end

  test "visiting the index" do
    visit logins_url
    assert_selector "h1", text: "Logins"
  end

  test "should create login" do
    visit logins_url
    click_on "New login"

    fill_in "Device", with: @login.device_id
    fill_in "Ip address", with: @login.ip_address
    fill_in "User agent", with: @login.user_agent
    fill_in "User", with: @login.user_id
    click_on "Create Login"

    assert_text "Login was successfully created"
    click_on "Back"
  end

  test "should update Login" do
    visit login_url(@login)
    click_on "Edit this login", match: :first

    fill_in "Device", with: @login.device_id
    fill_in "Ip address", with: @login.ip_address
    fill_in "User agent", with: @login.user_agent
    fill_in "User", with: @login.user_id
    click_on "Update Login"

    assert_text "Login was successfully updated"
    click_on "Back"
  end

  test "should destroy Login" do
    visit login_url(@login)
    click_on "Destroy this login", match: :first

    assert_text "Login was successfully destroyed"
  end
end
