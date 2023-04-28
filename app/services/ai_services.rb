# frozen_string_literal: true

class AiServices
  private_class_method :new

  DEFAULT_SERVICE = "chat"
  DEFAULT_MODEL = "gpt-3.5-turbo"

  def self.instance
    @instance ||= new
  end

  def initialize
    @selected_service_name = nil
    @selected_service_model = nil
  end

  attr_accessor :selected_service_name, :selected_service_model

  def list
    [
      OpenStruct.new(service: openai_services),
      OpenStruct.new(service: cohere_services)
    ]
  end

  def selected_service
    if @selected_service_name
      list.find { |section| section.services.find { |service| service.name == @selected_service_name } }
    end
  end

  protected

  # - /chat/completions
  # - /completions
  # - /edits
  # ....

  def openai_services
    @openai_services ||= JSON.parse({
      section: "OpenAI",
      services: [
        {
          name: "chat",
          url: "/chat/completions",
          models: [
            "gpt-4",
            "gpt-4-32k",
            "gpt-3.5-turbo",
            "text-davinci-003",
            "text-davinci-002",
            "code-davinci-002"
          ],
          parameters: [
            "temperature:0.5",
            "top_p:1",
            "n:1",
            "stop:",
            "max_tokens:100",
            "presence_penalty:0",
            "frequency_penalty:0",
            "logit_bias:"
          ]
        },
        {
          name: "completions",
          path: "/completions",
          models: [
            "text-davinci-003",
            "text-davinci-002",
            "code-davinci-002"
          ],
          parameters: [
            "suffix",
            "max_tokens:100",
            "temperature:0.5",
            "top_p:1",
            "n:1",
            "logprobs:",
            "echo:false",
            "stop:",
            "presence_penalty:0",
            "frequency_penalty:0",
            "best_of:1",
            "logit_bias:"
          ]
        }
      ]
    }.to_json, object_class: OpenStruct)
  end

  def cohere_services
    @cohere_services ||= JSON.parse({
      section: "Cohere",
      services: []
    }.to_json, object_class: OpenStruct)
  end
end
