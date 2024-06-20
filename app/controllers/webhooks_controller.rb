# frozen_literal_string: true

class WebhooksController < ApplicationController
  skip_forgery_protection
  before_action :set_stripe_api_key, only: :stripe
  before_action :set_webhook, only: :stripe

  def stripe
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]

    event = nil

    begin
      event = Stripe::Webhook.construct_event(payload, sig_header, @endpoint_secret)
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

      user_has_lesson = user.user_lessons.joins(:lesson).where(lessons: { course_id: course.id }).exists?

      progress = if user_has_lesson
                   Progress.find_by(name: "In Progress")
                 else
                   Progress.find_by(name: "Todo")
                 end

      UserCourse.create!(course:, user:, progress:)
    else
      puts "Unhandled event type #{event.type}"
    end

    render json: { message: "success" }
  end

  private

  def set_stripe_api_key
    Stripe.api_key = stripe_secret_key
  end

  def stripe_secret_key
    ENV["STRIPE_SECRET_KEY"]
  end

  def set_webhook
    @endpoint_secret = ENV["WEBHOOK_SECRET"]
  end
end
