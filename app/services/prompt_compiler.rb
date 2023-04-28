# frozen_string_literal: true

class PromptCompiler
  # Creates a new instance of PromptCompiler with the given prompt and variables
  # Internally it uses the Mustache gem to compile the prompt
  # @param prompt [String | Hash]
  # @param variables [Hash]
  def initialize(prompt, variables)
    @prompt = prompt
    @variables = variables
  end

  def compile
    raise "Prompt must be a String or a Hash" unless @prompt.is_a?(Array) || @prompt.is_a?(String)

    return Mustache.render(@prompt, @variables) if @prompt.is_a?(String)

    result = @prompt.deep_dup
    result.each do |hash|
      hash.each do |key, value|
        hash[key] = Mustache.render(value, @variables)
      end
    end

    result
  end
end
