module LtFormHelper

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

  def lt_klass_connector_form(klass, lt, f)
    if lt.new_record?
      html_string = choose_connected_klasses(klass, lt, f)
    else
      if lt.klasses.length > 1
        html_string = content_tag(:p) do
          display_connected_klasses_block(klass, lt)
        end
      end
      html_string.html_safe
    end
  end

  def display_connected_klasses_block(klass, lt)
    b = content_tag(:p, "This Learning Target is connect to these classes:")
    lt.klasses.each do |kl|
      b << kl.name if kl != klass
    end
    b
  end

  def choose_connected_klasses(klass, lt, f)
    html_string = content_tag(:p, "Add this learning target to another class:")
    current_user.klasses.each do |kl|
      if kl != klass
        html_string << f.fields_for(:klasses, kl) do |k|
          content_tag(:p) do
            b = f.check_box(:id)
            b << f.label(kl.name)
            b
          end
        end
      end
    end
    html_string.html_safe
  end

  def delete_button(klass, lt)
    if !lt.new_record?
      html_string = form_for([klass, lt], method: :delete) do |d|
        d.submit("delete")
      end
    end
    html_string.html_safe
  end


end
