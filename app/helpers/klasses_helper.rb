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

  def display_assignment_and_date(klass, assignment)
    link_to(edit_klass_assignment_path(klass, assignment)) do
      content_tag(:div, class: "assignment-header") do
        assignment_and_date(klass, assignment)
      end
    end
  end

  def assignment_and_date(klass, assignment)
    block = ""
    block << content_tag(:div, assignment.name)
    block << content_tag(:div, assignment.date_display, class: "date")
    block.html_safe
  end


  def blank_td?(lt)
    content_tag(:td, nil, class: "start-of-lt") if lt.assignments.empty?
  end


  def td_link_to_student(klass, student)
    content_tag(:td, class: "student-name") do
      link_to klass_student_path(klass, student) do
        content_tag(:div, class: "student-column") do
          student.full_name
        end
      end
    end
  end

  def td_student_average(student, klass_or_lt)
    content_tag(:td, class: ["average", "assignment-averages"]) do
      content_tag(:p) do
        content_tag(:strong) do
          student.average(klass_or_lt)
        end
      end
    end
  end

  def td_display_score(grade, index)
    content_tag(:td, class: td_classes(index, "score"), id: "#{grade.id}") do
      grade.score.to_s if grade
    end
  end

  def td_classes(index, initial_class=nil)
    array = [initial_class]
    array << "start-of-lt" if index == 0
    array
  end

  def klass_delete_button(klass)
    if !klass.new_record?
      form_for(klass, method: :delete) do |f|
        content_tag(:div, class: "big-button") do
          f.submit("Delete Class", data: { confirm: 'Are you sure you want to delete this class?'})
        end
      end
    end
  end

end
