module BasicAuth
  def encode_credentials(login, pass)
    ActionController::HttpAuthentication::Basic.encode_credentials(login, pass)
  end
end

RSpec.configure do |config|
  config.include BasicAuth
end
