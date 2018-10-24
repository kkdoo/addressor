class AddressPoolFetchService
  RUN_INTERVAL = 12.minutes

  include Concerns::HasAddressPoolRedis

  attr_reader :user, :error

  def initialize(user)
    @user = user
  end

  def call
    address = $redis.lpop(address_pool_key)
    if address
      unless user.update_attributes(address: address)
        assign_validation_error
      end
    else
      assign_pool_is_empty_error
    end
  end

  def assign_pool_is_empty_error
    @error = "Address Pool empty, please try again in #{next_run / 60} Minutes and #{next_run % 60} Seconds"
  end

  def assign_validation_error(user)
    @error = user.errors.full_messages.join(',')
  end

  protected
  def next_run
    time = Time.current
    passed = (time.to_f % RUN_INTERVAL).round
    RUN_INTERVAL - passed
  end
end
