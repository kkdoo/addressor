class Api::BaseController < ActionController::API
  include ExceptionHandler
  before_action :authorize_api_request!

  protected
  def authorize_api_request!
    if ActionController::HttpAuthentication::Basic.has_basic_credentials?(request)
      credentials = ActionController::HttpAuthentication::Basic.decode_credentials(request)
      token, _password = credentials.split(':')

      @current_user ||= Auth::AuthorizeApiRequestService.new(token).call
    else
      raise ExceptionHandler::DecodeError
    end
  end

  def current_user
    @current_user
  end
  helper_method :current_user
end
