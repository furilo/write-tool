# frozen_string_literal: true

module Api
  module V1
    class MeController < Api::BaseController
      def show
        render partial: "users/user", locals: {user: current_user}
      end

      def destroy
        current_user.destroy
        render json: {}
      end
    end
  end
end
