module CoursesHelper
  def active_tab_class
    'text-white bg-indigo-700 hover:bg-indigo-800 focus:outline-none focus:ring-4 focus:ring-indigo-300 font-medium rounded-full
    text-sm px-5 py-2.5 text-center mb-2 dark:bg-indigo-600
    dark:hover:bg-indigo-700 dark:focus:ring-indigo-900'
  end

  def inactive_tab_class
    'rounded-full bg-white px-3.5 py-2 text-sm font-semibold
    text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50'
  end

  def course_url(course)
    "#{root_url}#{course.slug}"
  end
end
