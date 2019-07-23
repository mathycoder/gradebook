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

end
