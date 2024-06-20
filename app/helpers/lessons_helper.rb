module LessonsHelper
  def lesson_watch_duration(lesson)
    "No lesson available" unless lesson.video.present?

    duration = lesson.video.blob.metadata[:duration]

    # Calculate hours, minutes, and seconds
    hours = (duration / 3600).floor
    minutes = ((duration % 3600) / 60).floor
    seconds = (duration % 60).floor

    # Format the output
    duration_str = ""
    duration_str += "#{pluralize(hours, "hr")} " if hours > 0
    duration_str += "#{pluralize(minutes, "min")} " if minutes > 0
    duration_str += "#{pluralize(seconds, "sec")}" if seconds > 0

    duration_str.strip # Remove any trailing spaces
  end
end
