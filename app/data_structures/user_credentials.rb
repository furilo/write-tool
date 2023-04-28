# frozen_string_literal: true

class UserCredentials < Struct.new(:user)
  def for(service)
    # user.credentials.find_by(service: service).token
    # TODO: temporary
    ENV["OPENAI_TOKEN"]
  end
end
