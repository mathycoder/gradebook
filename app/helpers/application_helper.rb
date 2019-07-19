module ApplicationHelper
  def error_display(resource)
    content_tag(:ul) do
      error_display_lis(resource)
    end
  end

  def error_display_lis(resource)
    if resource.errors.any?
      html_string = ""
      resource.errors.full_messages.each do |message|
        html_string << content_tag(:li, message)
      end
    html_string.html_safe
    end
  end

  def new_resource_button(klass, path, tag)
    form_tag(path, method: :get) do
      submit_tag(tag, class: "fancy-button")
    end
  end


end
