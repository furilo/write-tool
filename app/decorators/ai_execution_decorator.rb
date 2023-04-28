class AiExecutionDecorator < ApplicationDecorator
  delegate_all

  def response
    return h.content_tag(:p, "Loading...") if object.response.blank?

    case object.ai_unit.ai_service
    when :openai
      case object.ai_unit.ai_action
      when "chat/completions"
        object.parsed_response.choices.first.message.content
      when "completions"
        object.parsed_response.choices.first.text
      end
    end
  end
end
