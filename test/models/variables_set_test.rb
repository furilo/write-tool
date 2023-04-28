# == Schema Information
#
# Table name: variables_sets
#
#  id         :bigint           not null, primary key
#  name       :string
#  variables  :json
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_variables_sets_on_user_id  (user_id)
#
require "test_helper"

class VariablesSetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
