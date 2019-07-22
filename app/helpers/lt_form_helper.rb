module LtFormHelper

  def generate_standard_filter_form(lt, klass, standard, standards)
    if lt.new_record?
      html_string = form_tag(new_klass_learning_target_path(klass), method: "get") do
        generate_standard_filter_form_block(lt, klass, standard, standards)
      end
    else
      html_string = form_tag(edit_klass_learning_target_path(klass, lt), method: "get") do
        generate_standard_filter_form_block(lt, klass, standard, standards)
      end
    end
    html_string.html_safe
  end

  def generate_standard_filter_form_block(lt, klass, standard, standards)
    b = select_tag "query[grade]", options_from_collection_for_select(Standard.grades, :grade, :grade, display_grade(standard, standards)), class: "select-css", prompt: "Select a Grade"
    b << tag(:br) + tag(:br)
    b << submit_tag("Filter", class: "little-button")
    b << submit_tag('clear', class: "little-button")
    b << tag(:br)
    b
  end

  def display_grade(standard, standards)
    standard.try("id") ? standard.try("id") : standards.first.try("grade")
  end

  def delete_button(klass, lt)
    if !lt.new_record?
      html_string = form_for([klass, lt], method: :delete) do |d|
        d.submit("delete", data: { confirm: 'Are you sure you want to delete this learning target?'} )
      end
    html_string.html_safe
    end
  end
end
