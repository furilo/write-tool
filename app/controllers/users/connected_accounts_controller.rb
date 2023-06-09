# frozen_string_literal: true

module Users
  class ConnectedAccountsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_connected_account, only: [:destroy]

    def index
      @connected_accounts = current_user.connected_accounts.order(provider: :asc, created_at: :desc)
    end

    def destroy
      @connected_account.destroy
      redirect_to user_connected_accounts_path, status: :see_other
    end

    private

    def set_connected_account
      @connected_account = current_user.connected_accounts.find(params[:id])
    end
  end
end
