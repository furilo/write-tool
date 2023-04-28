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
class PromptProject < ApplicationRecord
  DEFAULT_TITLE = "New prompt"

  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  has_many :variables_sets, dependent: :destroy
  has_many :versions, class_name: "PromptProjectVersion", dependent: :destroy
  has_many :ai_executions, through: :versions

  # Broadcast changes in realtime with Hotwire
  # after_create_commit -> { broadcast_prepend_later_to :prompt_projects, partial: "prompt_projects/index", locals: {prompt_project: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  # after_destroy_commit -> { broadcast_remove_to :prompt_projects, target: dom_id(self, :index) }
  after_create :create_version

  enum :visibility, {hidden: 0, visible: 1}

  scope :sorted, -> { order(id: :desc) }

  def last_version
    @last_version ||= versions.last
  end

  def title_updated?
    title != DEFAULT_TITLE && !title.blank?
  end

  private

  def create_version
    versions.create!
  end
end
