require "test_helper"

class CertificateTest < ActiveSupport::TestCase
  def setup
    @user = users(:ninja)
    file = Rails.root.join("app", "assets", "images", "sample_certificate.png")

    @certificate = @user.certificates.build(title: "The Ninja Way", date_awarded: Time.now)
    @certificate.file = file
  end

  test "Certificate should be valid" do
    assert @certificate.valid?
  end

  test "Title should be present" do
    @certificate.title = ""
    assert_not @certificate.valid?
  end

  test "Title should be unique" do
    duplicate_certificate = @certificate.dup
    @certificate.save
    assert_not duplicate_certificate.valid?
  end

  test "Date awarded should be present" do
    @certificate.date_awarded = ""
    assert_not @certificate.valid?
  end

  test "Source should be valid" do
    valid_sources = %i[default linkedin udemy coursera]
    valid_sources.each do |source|
      @certificate.source = source
      assert @certificate.valid?, "#{source} should be valid."
    end
  end
end
