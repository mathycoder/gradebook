module KlassesHelper

  def student_link_td(student)
    html_string = content_tag(:td, class: "student-name") do
      content_tag(:div, class: "student-column") do
        student.full_name
      end
    end
  end

  def learning_target_link(klass, target)
    link_to(klass_learning_target_path(klass, target)) do
      learning_target_text(target)
    end
  end

  def learning_target_text(target)
    content_tag(:div, class: "lt-target-label") do
      block = ""
      block << target.standard.standard_notation_clean if target.standard
      block << tag(:br)
      block << target.name
      block.html_safe
    end
  end

  def assignment_label
    content_tag(:div, "Assignments", class: "assignment-label")
  end

  def klass_title(klass)
    content_tag(:th, rowspan: "2") do
      render partial: "klasses/klass_title", locals: {klass: klass}
    end
  end

  def klass_details(klass)
    content_tag(:div, id: "class-details") do
      block = ""
      block << content_tag(:strong, "Subject: ") + klass.subject
      block << content_tag(:strong, "\sGrade: ") + klass.grade
      block << content_tag(:strong, "\sPeriod: ") + klass.period.to_s
      block << tag(:br) + tag(:br)
      block.html_safe
    end
  end

  def klass_gradebook_title(klass)
    content_tag(:h2) do
      content_tag(:strong) do
        block = "#{klass.name}'s Gradebook"
        block << tag(:br)
        block.html_safe
      end
    end
  end

end
