# frozen_string_literal: true

module CoursesHelper
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
      'inline-flex items-center px-4 py-2 text-sm font-medium text-gray-900 bg-transparent border-t border-b border-r border-gray-900 hover:bg-gray-900 hover:text-white focus:z-10 focus:ring-2 focus:ring-gray-500 focus:bg-gray-900 focus:text-white'
    end
  end
end
