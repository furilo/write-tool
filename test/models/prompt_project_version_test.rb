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
require "test_helper"

class PromptProjectVersionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
