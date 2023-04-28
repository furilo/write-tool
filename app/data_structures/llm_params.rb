# frozen_string_literal: true

class LlmParams < Struct.new(:service, :action, :model, :model_params)
end
