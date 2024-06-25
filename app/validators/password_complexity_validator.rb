# app/validators/password_validator.rb

class PasswordComplexityValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.nil? || value.empty?

    unless value =~ /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,128}$/
      record.errors.add(attribute, options[:message] || "must contain at least one digit, one lowercase letter, one uppercase letter, one special character, and be between 8-128 characters long")
    end
  end
end
