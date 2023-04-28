# == Schema Information
#
# Table name: ai_units
#
#  id                        :bigint           not null, primary key
#  llm_params                :json
#  name                      :string
#  prompt                    :json
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  prompt_project_version_id :bigint           not null
#
# Indexes
#
#  index_ai_units_on_prompt_project_version_id  (prompt_project_version_id)
#
# Foreign Keys
#
#  fk_rails_...  (prompt_project_version_id => prompt_project_versions.id)
#
class AiUnit < ApplicationRecord
  DEFAULT_LLM_PARAMS = {
    service: "openai",
    action: "chat/completions",
    model: "gpt-3.5-turbo",
    model_params: {temperature: 0.2, max_tokens: 100, top_p: 1, frequency_penalty: 0.5, presence_penalty: 0.5}
  }

  # Broadcast changes in realtime with Hotwire
  after_create_commit -> {
    broadcast_replace_later_to :ai_units, target: "ai_units", partial: "ai_units/index", locals: {
      prompt_project_version: prompt_project_version
    }
  }
  # after_update_commit -> { broadcast_replace_later_to self }
  # after_destroy_commit -> { broadcast_remove_to :ai_unit, target: dom_id(self, :index) }

  belongs_to :prompt_project_version
  has_many :ai_executions

  scope :sorted, -> { order(id: :desc) }

  def prompt_content=(content)
    write_attribute :prompt, [
      {
        role: "user", content: content
      }
    ]
  end

  def prompt_content
    return "" if prompt.blank?

    prompt.first["content"]
  end

  def ai_service
    llm_params&.dig("service")&.downcase&.to_sym
  end

  def ai_action
    llm_params&.dig("action")&.downcase
  end

  def ai_model
    llm_params&.dig("model")&.downcase
  end
end
