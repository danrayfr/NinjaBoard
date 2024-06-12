# frozen_literal_string: true

class CheckoutsController < ApplicationController
  prepend_before_action :authenticate_user!
  before_action :set_stripe_api_key, only: :create

  # Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
  DEFAULT_QTY = 1

  def create
    course = Course.friendly.find params[:course_id]

    session = Stripe::Checkout::Session.create(
      mode: "payment",
      line_items: [{
        price: course.stripe_price_id,
        quantity: DEFAULT_QTY
      }],
      success_url: course_success_url(course),
      cancel_url: course_cancel_url(course),
      automatic_tax: { enabled: true },
      customer_email: current_user.email,
      metadata: { course_id: course.id }
    )

    redirect_to session.url, allow_other_host: true
  end

  private

  def set_stripe_api_key
    Stripe.api_key = stripe_secret_key
  end

  def stripe_secret_key
    ENV["STRIPE_SECRET_KEY"]
  end

  def course_success_url(course)
    "#{request.base_url}/courses/#{course.slug}?status=success"
  end

  def course_cancel_url(course)
    "#{request.base_url}/courses/#{course.slug}?status=cancel"
  end
end
