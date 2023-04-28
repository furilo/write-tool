# frozen_string_literal: true

class Executor
  # Creates a new instance of Executor
  # @param prompt [String]
  # @param user_credentials [UserCredentials]
  # @param llm_params [LlmParams]
  # @param variables [Hash]
  def initialize(prompt:, user_credentials:, llm_params:, variables:)
    @prompt = prompt
    @user_credentials = user_credentials
    @llm_params = llm_params.is_a?(Hash) ? OpenStruct.new(llm_params) : llm_params
    @variables = variables
  end

  attr_reader :prompt, :user_credentials, :llm_params, :variables

  def run
    client = build_client(token: user_credentials.for(llm_params.service), llm_params:)
    compiled_prompt = PromptCompiler.new(prompt, variables).compile
    client.execute(compiled_prompt)
  end

  private

  def build_client(token:, llm_params:)
    OpenAiClient.new(token:, llm_params:)
  end
end
