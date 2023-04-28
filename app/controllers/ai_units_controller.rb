# frozen_string_literal: true

class AiUnitsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_prompt_project_version

  def create
    @prompt_project_version.ai_units.create llm_params: AiUnit::DEFAULT_LLM_PARAMS, prompt: []
  end

  def update
    @ai_unit = @prompt_project_version.ai_units.find(params[:id])
    @ai_unit.update(ai_unit_params)
  end

  private

  def ai_unit_params
    params.require(:ai_unit).permit(:prompt_content, :llm_params, :name)
  end
end
