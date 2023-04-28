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
require "test_helper"

class AiExecutionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
