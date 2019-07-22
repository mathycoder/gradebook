module KlassesHelper

  def student_link_td(student)
    html_string = content_tag(:td, class: "student-name") do
      content_tag(:div, class: "student-column") do
        student.full_name
      end
    end
  end
end
