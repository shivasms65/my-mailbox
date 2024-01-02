class MailBoxController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service

  def index
    @emails = @service.list_user_messages('me', max_results: 15)
  end

  def show
    @email = @service.get_user_message('me', params[:id])
  end

  private

  def set_service
    @client = Signet::OAuth2::Client.new(access_token: current_user.token)
    @service = Google::Apis::GmailV1::GmailService.new
    @service.authorization = @client
  end
end
