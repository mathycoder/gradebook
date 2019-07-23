module AssignmentsHelper
  def assignment_delete_button(klass, assignment)
    if !assignment.new_record?
      form_for([klass, assignment], method: :delete) do |f|
        content_tag(:div, class: "big-button") do
          f.submit("Delete Assignment", data: { confirm: 'Are you sure you want to delete this assignment?'})
        end
      end
    end
  end

  def assignment_form_title(klass, add_or_edit)
    content_tag(:h1, "#{add_or_edit} #{klass.name}" )
  end


  def display_field_for_grades(f, student, assignment)
    content_tag(:tr) do
      f.fields_for(:grades, student.current_grade(assignment), include_id: false) do |br|
        student_name_and_score_field(student, br)
      end
    end
  end


  def student_name_and_score_field(student, br)
     content_tag(:div) do
       html_string = ""
       html_string << content_tag(:td, br.label(:score, student.full_name))
       html_string << content_tag(:td, br.label(:score, br.text_field(:score, {class: "text-field-grade", maxlength: "3"})))
       html_string << br.hidden_field(:student_id, :value => student.id)
       html_string.html_safe
     end
  end


end
