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
require "test_helper"

class AiUnitTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
