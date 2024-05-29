module PagesHelper
  def button_tabs(tab)
    content_tag(:button, "#{tab}", id: "#{tab}", data: { tabs_target: 'btn', action: 'click->tabs#select'}, type: 'button', class: 'capitalize px-4 py-2 text-sm font-medium text-gray-900 bg-transparent border border-gray-900 rounded-s-lg hover:bg-gray-900 hover:text-white focus:z-10 focus:ring-2 focus:ring-gray-500 focus:bg-gray-900 focus:text-white active')
  end
end
