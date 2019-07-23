module KlassesHelper

  def student_link_td(student)
    html_string = content_tag(:td, class: "student-name") do
      content_tag(:div, class: "student-column") do
        student.full_name
      end
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

end
