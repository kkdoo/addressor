module ExceptionHandler
  extend ActiveSupport::Concern
  class DecodeError < StandardError; end
  class ExpiredSignature < StandardError; end
  class InvalidCredentials < StandardError; end

  included do
    rescue_from ExceptionHandler::DecodeError do |_error|
      render json: {
        message: "Access denied!. Invalid token supplied."
      }, status: 401
    end
    rescue_from ExceptionHandler::ExpiredSignature do |_error|
      render json: {
        message: "Access denied!. Token has expired."
      }, status: 401
    end
    rescue_from ExceptionHandler::InvalidCredentials do |_error|
      render json: {
        message: "Access denied!. Invalid credentials"
      }, status: 401
    end
  end
end
