# frozen_string_literal: true

## Multitenant Account Middleware
#
# Included in the Rails engine if enabled.
#
# Used for setting the Account by the first ID in the URL like Basecamp 3.
# This means we don't have to include the Account ID in every URL helper.

module Jumpstart
  class AccountMiddleware
    def initialize(app)
      @app = app
    end

    # http://example.com/12345/projects
    # http://example.com/12345-account/projects
    def call(env)
      request = ActionDispatch::Request.new env
      _, account_id, request_path = request.path.split("/", 3)

      if /^\d+/.match?(account_id)
        return [302, {"Location" => "/"}, []] unless (account = Account.find_by(id: account_id))

        Current.account = account

        request.script_name = "/#{account_id}"
        request.path_info = "/#{request_path}"
      end

      @app.call(request.env)
    end
  end
end
