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
class VariablesSet < ApplicationRecord
  # Broadcast changes in realtime with Hotwire
  # after_create_commit -> { broadcast_prepend_later_to :variables_sets, partial: "variables_sets/index", locals: {variables_set: self} }
  # after_update_commit -> { broadcast_replace_later_to self }
  # after_destroy_commit -> { broadcast_remove_to :variables_sets, target: dom_id(self, :index) }

  belongs_to :user
  has_many :ai_executions

  def variables_serialized=(value)
    self.variables = Hash[*value]
  end
end
