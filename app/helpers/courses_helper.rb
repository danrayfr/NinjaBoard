# frozen_string_literal: true

module CoursesHelper
  def course_watch_duration(course)
    # Return "empty" if the course has no lessons
    return "No lesson available" if course.lessons.empty?

    # Calculate the total duration in seconds, ensuring we handle cases with missing videos or metadata
    total_seconds = course.lessons.sum do |lesson|
      if lesson.video.present? && lesson.video.blob.metadata[:duration]
        lesson.video.blob.metadata[:duration]
      else
        0
      end
    end

    # Return "empty" if no video durations are found
    return "0 sec" if total_seconds.zero?

    # Calculate hours, minutes, and seconds
    hours = (total_seconds / 3600).floor
    minutes = ((total_seconds % 3600) / 60).floor
    seconds = (total_seconds % 60).floor

    # Format the output
    duration_str = ""
    duration_str += "#{pluralize(hours, "hr")} " if hours > 0
    duration_str += "#{pluralize(minutes, "min")} " if minutes > 0
    duration_str += "#{pluralize(seconds, "sec")}" if seconds > 0

    duration_str.strip # Remove any trailing spaces
  end

  def active_tab_class
    'text-white bg-indigo-700 hover:bg-indigo-800 focus:outline-none focus:ring-4 focus:ring-indigo-300 font-medium rounded-full
    text-sm px-5 py-2.5 text-center mb-2'
  end

  def inactive_tab_class
    'rounded-full bg-white px-3.5 py-2 text-sm font-semibold
    text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50'
  end

  def course_url(course)
    "#{root_url}#{course.slug}"
  end

  def button_group_class(courses, index)
    if index.zero?
      'inline-flex items-center px-4 py-2 text-sm font-medium text-gray-900 bg-transparent border border-gray-900 rounded-s-lg hover:bg-gray-900 hover:text-white focus:z-10
      focus:ring-2 focus:ring-gray-500 focus:bg-gray-900 focus:text-white'
    elsif index == courses.length - 1
      'inline-flex items-center px-4 py-2 text-sm font-medium text-gray-900 bg-transparent border-r border-t border-b  border-gray-900 rounded-e-lg hover:bg-gray-900 hover:text-white focus:z-10
      focus:ring-2 focus:ring-gray-500 focus:bg-gray-900 focus:text-white'
    else
      "inline-flex items-center px-4 py-2 text-sm font-medium text-gray-900 bg-transparent border-t border-b border-r border-gray-900 hover:bg-gray-900 hover:text-white focus:z-10 focus:ring-2 focus:ring-gray-500 focus:bg-gray-900 focus:text-white"
    end
  end

  # rubocop:disable Metrics/MethodLength
  def course_enrolled_by_user(user, course)
    if AssignedCourse.exists?(user:, course_id: course.id)
      content_tag(:p, "You have already enrolled this course.", class: "text-md font-semibold")
    else
      form_tag assigned_courses_path(course_id: course.id), method: :post, class: "inline-form",
                                                            data: { turbo_frame: "course-form" } do
        button_tag "Get Course",
                   type: :submit,
                   class: 'rounded-sm bg-black px-3.5 py-2.5 text-sm border-2 border-black
        font-semibold text-white shadow-sm hover:bg-white hover:text-black hover:border-2 hover:border-black w-full'
      end
    end
  end
  # rubocop:enable Metrics/MethodLength

  def course_percentage(user_course_progresses, course)
    user_course_progresses.find { |cp| cp[:course_id] == course.id } [:completed_percentage]
  end

  def user_already_enrolled?(course, user)
    UserCourse.exists?(user:, course_id: course.id)
  end

  def enroll_form_for(course)
    form_tag user_courses_path(course_id: course.id), method: :post, class: "inline-form",
                                                      data: { turbo_frame: "course-form" } do
      button_tag "Get Course", type: :submit,
                               class: "items-center inline-flex w-full focus:outline-disc bg-green-500 duration-500 focus:ring-2 focus:ring-green-600 focus:ring-offset-2 font-medium h-12 hover:bg-green-600 justify-center px-6 py-1 gap-3 rounded-full text-white text-center text-sm md:w-auto"
    end
  end
end
