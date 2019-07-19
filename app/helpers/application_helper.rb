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

  def current_klass(klass)
    klass ? (klass) : (current_user.klasses.build)
  end

  def klass_dropdown(klass)
    form_for([:klass, current_klass(klass)], url: klass_redirect_path(), method: :get) do |f|
      f.collection_select(:id, current_user.klasses_in_alphabetical_order, :id, :klass_name, {include_blank: "Classes"}, {class: "select-blend", onchange: "this.form.submit();"})
    end
  end

  def current_lt(klass, lt)
    lt ? (current_lt = lt) : (current_lt = klass.learning_targets.build)
  end

  def lt_dropdown(klass, lt)
    form_for([:learning_target, current_lt(klass, lt)], url: lt_redirect_path(klass), method: :get) do |f|
      f.collection_select(:name, klass.learning_targets, :name, :name, {include_blank: "All Learning Targets", prompt: "Learning Targets"}, {class: "select-blend", onchange: "this.form.submit();"})
    end
  end


end
