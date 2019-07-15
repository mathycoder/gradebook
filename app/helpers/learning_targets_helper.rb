module LearningTargetsHelper

  def generate_standard_filter_form(lt, klass, standard)
    if lt.new_record?
      f = form_tag(new_klass_learning_target_path(klass), method: "get") do
        generate_standard_filter_form_block(lt, klass, standard)
      end
    else
      f = form_tag(edit_klass_learning_target_path(klass, lt), method: "get") do
        generate_standard_filter_form_block(lt, klass, standard)
      end
    end
    f.html_safe
  end

  def generate_standard_filter_form_block(lt, klass, standard)
    b = select_tag "query[grade]", options_from_collection_for_select(Standard.grades, :grade, :grade, standard.try("id")), prompt: "Select a Grade"
    b << tag(:br) + tag(:br)
    b << submit_tag("Filter")
    b << submit_tag('clear')
    b << tag(:br)
    b
  end
end
