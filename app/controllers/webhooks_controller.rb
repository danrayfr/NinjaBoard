# frozen_literal_string: true

class WebhooksController < ApplicationController
  skip_forgery_protection

  def stripe
    Stripe.api_key = stripe_secret_key
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
    endpoint_secret = webhook

    event = nil

    begin
      event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
    rescue JSON::ParserError
      status 400
      return
    rescue Stripe::SignatureVerificationError
      puts "Webhook signature verification failed."
      status 400
      return
    end

    case event.type
    when "checkout.session.completed"
      session = event.data.object

      full_session = Stripe::Checkout::Session.retrieve({ id: session.id, expand: ["line_items"] })

      line_items = full_session.line_items
      puts "session: #{session}"
      puts "line items: #{line_items}"
      course_id = session.metadata.course_id
      course = Course.find(course_id)
      user = User.find_by!(email: session.customer_email)

      UserCourse.create!(course:, user:)
      UserLesson.

        else
      puts "Unhandled event type #{event.type}"
    end

    render json: { message: "success" }
  end

  protected

  def stripe_secret_key
    ENV["STRIPE_SECRET_KEY"]
  end

  def webhook
    ENV["WEBHOOK_SECRET"]
  end
end
