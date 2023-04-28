class ExecutionsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_prompt_project_version

  def create
    @prompt_project_version.ai_units.each do |ai_unit|
      next if ai_unit.prompt.blank?

      @prompt_project_version.variables_sets.each do |variables_set|
        # Create the execution with empty response
        @prompt_project_version.ai_executions.find_or_create_by ai_unit: ai_unit, variables_set: variables_set

        ExecutorJob.perform_later @prompt_project_version.id, ai_unit.id, variables_set.id
      end
    end
  end
end
