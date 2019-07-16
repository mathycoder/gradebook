module LtFormHelper

  def generate_standard_filter_form(lt, klass, standard)
    if lt.new_record?
      html_string = form_tag(new_klass_learning_target_path(klass), method: "get") do
        generate_standard_filter_form_block(lt, klass, standard)
      end
    else
      html_string = form_tag(edit_klass_learning_target_path(klass, lt), method: "get") do
        generate_standard_filter_form_block(lt, klass, standard)
      end
    end
    html_string.html_safe
  end

  def generate_standard_filter_form_block(lt, klass, standard)
    b = select_tag "query[grade]", options_from_collection_for_select(Standard.grades, :grade, :grade, standard.try("id")), class: "select-css", prompt: "Select a Grade"
    b << tag(:br) + tag(:br)
    b << submit_tag("Filter", class: "little-button")
    b << submit_tag('clear', class: "little-button")
    b << tag(:br)
    b
  end

  # def lt_klass_connector_form(klass, lt, f)
  #   if lt.new_record?
  #     html_string = choose_connected_klasses(klass, lt, f).html_safe
  #   else
  #     html_string = content_tag(:p) do
  #       display_connected_klasses(klass, lt).html_safe
  #     end
  #   end
  # end
  #
  # def display_connected_klasses(klass, lt)
  #   b = content_tag(:p, "This Learning Target is connect to these classes:")
  #   lt.klasses.each do |kl|
  #     b << kl.name if kl != klass
  #   end
  #   b
  # end
  #
  # def choose_connected_klasses(klass, lt, f)
  #   f.fields_for(:klasses, lt.klasses.build) do |k|
  #     k.collection_check_boxes(:id, current_user.klasses, :id, :name)
  #   end
  # end

  def delete_button(klass, lt)
    if !lt.new_record?
      html_string = form_for([klass, lt], method: :delete) do |d|
        d.submit("delete")
      end
    html_string.html_safe
    end
  end
end
