module ApplicationHelper
	def flash_class(type)
    case type
    when :notice then 'alert-info'
    when :alert then 'alert-warning'
    else 'alert-info'
    end
  end
  
	def bootstrap_form_field(f, field, &block)
		div_style = ['form-group']
		has_any_errors = f.object.errors.present?
		has_field_errors = f.object.errors[field].present?
		if has_any_errors
			div_style << 'has-feedback'
			div_style << (has_field_errors ? 'has-error' : 'has-success')
		end
		content_tag(:div, class: div_style.join(' ')) do
			inner = f.label(field, class: 'col-sm-2 control-label')
			inner += content_tag(:div, class: 'col-sm-10') do
				block.call if block
			end
			if has_any_errors
				if has_field_errors
					inner += content_tag(:i, nil, class: 'glyphicon glyphicon-remove form-control-feedback')
				else
					inner += content_tag(:i, nil, class: 'glyphicon glyphicon-ok form-control-feedback')
				end
			end
			inner
		end
	end
end
