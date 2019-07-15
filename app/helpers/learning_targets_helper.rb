module LearningTargetsHelper

  def generate_standard_filter_form(lt, klass)
    if !lt.name
      f = form_tag(new_klass_learning_target_path(klass), method: "get") do
        b = select_tag "query[grade]", options_from_collection_for_select(Standard.grades, :grade, :grade, @standard.try("id")), prompt: "Select a Grade"
        b << tag(:br)
        b << tag(:br)
        b << submit_tag("Filter")
        b << submit_tag('clear')
        b << tag(:br)
        b
      end
    else
      f = form_tag(edit_klass_learning_target_path(klass, lt), method: "get") do
        b = select_tag "query[grade]", options_from_collection_for_select(Standard.grades, :grade, :grade, @standard.try("id")), prompt: "Select a Grade"
        b << tag(:br)
        b << tag(:br)
        b << submit_tag("Filter")
        b << submit_tag('clear')
        b << tag(:br)
        b
      end
    end
    f.html_safe
  end
end
