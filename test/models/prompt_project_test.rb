# == Schema Information
#
# Table name: prompt_projects
#
#  id          :bigint           not null, primary key
#  description :text
#  slug        :string
#  title       :string
#  visibility  :integer          default("hidden")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_prompt_projects_on_slug        (slug)
#  index_prompt_projects_on_user_id     (user_id)
#  index_prompt_projects_on_visibility  (visibility)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class PromptProjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
