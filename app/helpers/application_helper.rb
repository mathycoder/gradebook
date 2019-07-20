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

  def logo_button(klass, path)
    link_to(path) do
      content_tag(:div, class: "header-logo") do
        image_tag('open-book.jpg')
      end
    end
  end

  def new_resource_button(klass, path, tag)
    html_string = content_tag(:div) do
      form_tag(path, method: :get) do
        submit_tag(tag, class: "fancy-button")
      end
    end
    html_string.html_safe
  end

  def current_klass(klass)
    klass ? klass : Klass.new
  end

  def klass_dropdown(klass)
    content_tag(:div, class: "class-header") do
      form_for([:klass, current_klass(klass)], url: klass_redirect_path(), method: :get) do |f|
        f.collection_select(:id, current_user.klasses_in_alphabetical_order, :id, :klass_name, {include_blank: "Classes"}, {class: "select-blend", onchange: "this.form.submit();"})
      end
    end
  end

  def current_lt(klass, lt)
    lt ? lt : LearningTarget.new
  end

  def lt_dropdown(klass, lt)
    content_tag(:div, class: "header-select") do
      form_for([:learning_target, current_lt(klass, lt)], url: lt_redirect_path(klass), method: :get) do |f|
        f.collection_select(:name, klass.learning_targets, :name, :name, {include_blank: "All Learning Targets", prompt: "Learning Targets"}, {class: "select-blend", onchange: "this.form.submit();"})
      end
    end
  end

  def current_student(klass, student)
    student ? student : Student.new
  end

  def student_dropdown(klass, student)
    content_tag(:div, class: "header-select") do
      form_for([:student, current_student(klass, student)], url: student_redirect_path(klass), method: :get) do |f|
        f.collection_select(:id, klass.students, :id, :first_last_name, {prompt: "Students"}, {class: "select-blend", onchange: "this.form.submit();"})
      end
    end
  end

  def logout_link()
    content_tag(:div, class: "header-logout") do
      link_to("Log Out", logout_path)
    end
  end

  def login_link()
    content_tag(:div, class: "header-login") do
      link_to("Log In", login_path)
    end
  end

  def signup_link()
    content_tag(:div, class: "header-signup") do
      link_to("Sign Up", signup_path)
    end 
  end

end
