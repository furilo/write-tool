# frozen_string_literal: true

class ExecutorJob < ApplicationJob
  queue_as :critical

  def perform prompt_project_version_id, ai_unit_id, variable_set_id
    prompt_project_version = PromptProjectVersion.find_by id: prompt_project_version_id
    return if prompt_project_version.nil?

    ai_unit = prompt_project_version.ai_units.find_by id: ai_unit_id
    return if ai_unit.nil?

    variables_set = VariablesSet.find_by id: variable_set_id

    execution = prompt_project_version.ai_executions.find_or_initialize_by ai_unit: ai_unit, variables_set: variables_set
    return if !execution.pending_execution?

    user_credentials = UserCredentials.new nil
    executor = Executor.new prompt: ai_unit.prompt, user_credentials: user_credentials, llm_params: ai_unit.llm_params, variables: variables_set&.variables
    response = executor.run

    execution.response = response.raw_response
    execution.save!
  end
end
