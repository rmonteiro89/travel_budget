module ApplicationHelper

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      message = message.html_safe
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in text-center") do
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message
            end)
    end
    nil
  end

  def bootstrap_class_for(flash_type)
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end
end
