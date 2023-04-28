# frozen_string_literal: true

class OpenAiClient < ApplicationClient
  BASE_URI = "https://api.openai.com/v1/"

  def initialize(token:, llm_params:)
    @token = token
    @llm_params = llm_params
  end

  attr_reader :token, :llm_params

  # - /chat/completions
  # - /completions
  # - /edits
  # ....
  def execute(prompt)
    post path, body: {
      model: llm_params.model,
      messages: prompt
    }.merge(llm_params.model_params)
  end

  def parse_response(response)
    OpenStruct.new raw_response: response.body, parsed_response: super(response)
  end

  private

  def path
    llm_params.action
  end
end
