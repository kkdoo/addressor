class Auth::AuthenticateUserService

  attr_reader :email, :password

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  def user
    user = User.find_by(email: email)
    return user if user && user.valid_password?(password)

    raise ExceptionHandler::InvalidCredentials
  end
end
