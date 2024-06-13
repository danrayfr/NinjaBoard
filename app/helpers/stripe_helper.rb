module StripeHelper
  extend self

  def display_course_price(course, user)
    if course.paid? && UserCourse.where(course: course, user: user).exists?
      "Enrolled"
    elsif course.paid?
      price = fetch_stripe_price(course.stripe_price_id)
      "Price: #{formatted_price(price.unit_amount_decimal, price.currency)}"
    else
      "Free"
    end
  end

  private

  def fetch_stripe_price(price_id)
    begin
      Stripe::Price.retrieve(price_id)
    rescue Stripe::StripeError => e
      Rails.logger.error "Stripe error while retrieving price: #{e.message}"
      nil
    end
  end

  def formatted_price(amount, currency)
    sprintf("%.2f", amount.to_f / 100) # Formats the amount to two decimal places
  end
end
