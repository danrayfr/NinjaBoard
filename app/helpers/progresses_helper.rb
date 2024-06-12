module ProgressesHelper
  def completed_svg(param)
    if param.date_completed.nil?
      icon "fa-solid", "calendar-days", class: "w-6"
    else
      icon "fa-solid", "calendar-check", class: "w-6"
    end.html_safe
  end

  def completed_card_color(param)
    if param.date_completed.nil?
      "border-2 hover:border-dashed border-transparent hover:border-gold border-coral border-dashed"
    else
      "border-2 hover:border-dashed border-transparent hover:border-indigo-600 bg-paleFern text-offWhite"
    end
  end
end
