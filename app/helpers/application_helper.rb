module ApplicationHelper
  def invalid_feedback_for(errors, attribute)
    if errors && errors[attribute]
      tag.div class: 'invalid-feedback' do
        case errors[attribute]
        in Symbol
          t("#{controller_name}.#{action_name}.#{attribute}.#{errors[attribute]}")
        in Hash
          t("#{controller_name}.#{action_name}.#{attribute}.dynamic", errors: errors[attribute])
        end
      end
    end
  end
end
