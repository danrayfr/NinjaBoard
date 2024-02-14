# frozen_string_literal: true

module Courses
  class UnpublishController < ApplicationController
    def update
      @course = Course.friendly.find(params[:id])
      @course.update(published: false)

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('publish-button', partial: 'courses/publish_button', locals: { course: @course.reload })
          ]
        end
      end
    end
  end
end
