# frozen_string_literal: true

class VariablesSetsController < ApplicationController
  before_action :authenticate_user!

  def new
    @prompt_project_version = load_prompt_project_version
  end

  def index
  end

  def create
    @variables_set = current_user.variables_sets.create(variables_set_params)
    prompt_project_version.variables_sets_ids << @variables_set.id
    prompt_project_version.save
  end

  def edit
    @variables_set = current_variables_set
  end

  def update
    @variables_set = current_variables_set
    @variables_set.update(variables_set_params)
  end

  private

  def variables_set_params
    params.require(:variables_set).permit(:name, variables_serialized: [])
  end

  def current_variables_set
    @current_variables_set ||= current_user.variables_sets.find(params[:id])
  end

  def prompt_project_version
    @prompt_project_version ||= PromptProjectVersion.find(params[:prompt_project_version_id])
  end
end
