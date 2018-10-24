class Auth::AuthorizeApiRequestService
  attr_reader :token

  def initialize(token)
    @token = token
  end

  def call
    user
  end

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    raise ExceptionHandler::DecodeError unless @user
    @user
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(token)
  end
end
