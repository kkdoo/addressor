class Api::SessionsController < Api::BaseController
  skip_before_action :authorize_api_request, only: [:create]

  def create
    if ActionController::HttpAuthentication::Basic.has_basic_credentials?(request)
      credentials = ActionController::HttpAuthentication::Basic.decode_credentials(request)
      email, password = credentials.split(':')

      render json: {auth_token: Auth::AuthenticateUserService.new(email, password).call}
    else
      raise ExceptionHandler::InvalidCredentials
    end
  end
end
