# == Schema Information
#
# Table name: prompt_project_versions
#
#  id                  :bigint           not null, primary key
#  executions_count    :integer          default(0)
#  variables_sets_ids  :bigint           default([]), is an Array
#  version             :integer          default(1), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  prompt_project_id   :bigint           not null
#  selected_ai_unit_id :bigint
#
# Indexes
#
#  index_prompt_project_versions_on_prompt_project_id    (prompt_project_id)
#  index_prompt_project_versions_on_selected_ai_unit_id  (selected_ai_unit_id)
#  index_prompt_project_versions_on_version              (version)
#
# Foreign Keys
#
#  fk_rails_...  (prompt_project_id => prompt_projects.id)
#  fk_rails_...  (selected_ai_unit_id => ai_units.id)
#
class PromptProjectVersion < ApplicationRecord
  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :prompt_project_versions, partial: "prompt_project_versions/index", locals: {prompt_project_version: self} }
  # after_update_commit -> { broadcast_replace_later_to self }
  # after_destroy_commit -> { broadcast_remove_to :prompt_project_versions, target: dom_id(self, :index) }

  belongs_to :prompt_project
  has_one :selected_ai_unit, class_name: "AiUnit", foreign_key: "selected_ai_unit_id"
  has_many :ai_units, dependent: :destroy
  has_many :ai_executions, dependent: :destroy, class_name: "AiExecution", foreign_key: "prompt_project_version_id"

  scope :sorted, -> { order(version: :desc) }

  def to_param
    version.to_s
  end

  def variables_sets
    VariablesSet.where(id: variables_sets_ids).order(id: :asc)
  end
end
