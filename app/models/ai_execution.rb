# == Schema Information
#
# Table name: ai_executions
#
#  id                        :bigint           not null, primary key
#  response                  :json
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  ai_unit_id                :bigint           not null
#  prompt_project_version_id :bigint           not null
#  variables_set_id          :bigint
#
# Indexes
#
#  index_ai_executions_on_ai_unit_id                 (ai_unit_id)
#  index_ai_executions_on_prompt_project_version_id  (prompt_project_version_id)
#  index_ai_executions_on_variables_set_id           (variables_set_id)
#
# Foreign Keys
#
#  fk_rails_...  (ai_unit_id => ai_units.id)
#  fk_rails_...  (prompt_project_version_id => prompt_project_versions.id)
#  fk_rails_...  (variables_set_id => variables_sets.id)
#
class AiExecution < ApplicationRecord
  # Broadcast changes in realtime with Hotwire
  after_update_commit -> { broadcast_replace_later_to :ai_executions, target: dom_id(self) }
  after_destroy_commit -> { broadcast_remove_to :ai_executions, target: dom_id(self, :index) }

  belongs_to :prompt_project_version
  belongs_to :variables_set, optional: true
  belongs_to :ai_unit

  def parsed_response
    @parsed_response ||= JSON.parse(response, object_class: OpenStruct)
  end

  def pending_execution?
    new_record? || response.blank? || ai_unit_updated?
  end

  private

  def ai_unit_updated?
    ai_unit.updated_at > updated_at
  end
end
