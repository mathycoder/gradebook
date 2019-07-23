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


end
