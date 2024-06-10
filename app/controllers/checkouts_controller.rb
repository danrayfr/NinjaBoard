# frozen_literal_string: true

class CheckoutsController < ApplicationController
  prepend_before_action :authenticate_user!

  Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
  DEFAULT_QTY = 1

  def create
    course = Course.friendly.find params[:course_id]

    session = Stripe::Checkout::Session.create(
      mode: 'payment',
      line_items: [{
        price: course.stripe_price_id,
        quantity: DEFAULT_QTY
      }],
      success_url: request.base_url + "/courses/#{course.id}",
      cancel_url: request.base_url + "/courses/#{course.id}",
      automatic_tax: { enabled: true },
      customer_email: current_user.email,
      metadata: { course_id: course.id }
    )

    redirect_to session.url, allow_other_host: true
  end

  protected

  def stripe_secret_key
    ENV["STRIPE_SECRET_KEY"]
  end
end
